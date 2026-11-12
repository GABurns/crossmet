#' @title Import weather data from Excel
#' @author Gareth Burns
#' @description Imports weather data from an Excel workbook where individual worksheets
#' contain data for separate years. Only worksheets required to cover the
#' requested date range are imported. The resulting data are combined,
#' filtered to the requested dates, and converted to long format.
#'
#' The Excel workbook is expected to contain the following columns:
#' `date`, `DOY`, `Temperature deg C`, `Air temp`, `Temp diff`, `Rainfall`,
#' `Soil 15cm`, `Soil 45cm`, `Average Wind`, `RH`, `Leaf`, and `Lite totals`.
#'
#' Worksheet names are expected to contain the four-digit year, for example
#' `"2023"`, `"2024"`, and `"2025"`.
#' @param file Character string. Path to the Excel workbook containing the
#'   weather data.
#' @param start_date Start date of the period to import. Either a `Date`
#'   object or an unambiguous date string such as `"2023-01-01"`.
#' @param end_date End date of the period to import. Either a `Date`
#'   object or an unambiguous date string such as `"2025-12-31"`.
#'
#' @return A tibble in long format with four columns: date, DOY, variable,
#'   and value.
#' @details Only worksheets corresponding to years between `start_date` and
#' `end_date` are read. Observations outside the requested date range are removed.
#' @examples
#' \dontrun{
#' weather <- ImportWeather("weather.xlsx", "2022-01-01", "2025-12-31")
#' }
#' @importFrom readxl excel_sheets read_excel cell_limits
#' @importFrom dplyr filter bind_rows mutate arrange
#' @importFrom tidyr pivot_longer
#' @export
ImportWeather <- function(file,
                          start_date = "2013-01-01",
                          end_date = Sys.Date()) {
  if (!file.exists(file)) {
    stop("Excel file does not exist: ", file, call. = FALSE)
  }

  parse_date <- function(x, argument) {
    if (length(x) != 1L || is.na(x)) {
      stop("`", argument, "` must be a single valid date.", call. = FALSE)
    }
    parsed <- tryCatch(
      suppressWarnings(as.Date(x)),
      error = function(e) as.Date(NA)
    )
    if (length(parsed) != 1L || is.na(parsed)) {
      stop("`", argument, "` must be a valid date.", call. = FALSE)
    }
    parsed
  }

  start_date <- parse_date(start_date, "start_date")
  end_date <- parse_date(end_date, "end_date")

  if (start_date > end_date) {
    stop("`start_date` must be earlier than or equal to `end_date`.",
         call. = FALSE)
  }

  years <- as.character(seq(
    as.integer(format(start_date, "%Y")),
    as.integer(format(end_date, "%Y"))
  ))

  sheets <- tryCatch(
    excel_sheets(file),
    error = function(e) {
      stop("Unable to read Excel workbook: ", conditionMessage(e),
           call. = FALSE)
    }
  )

  if (!length(sheets)) {
    stop("Excel workbook contains no worksheets.", call. = FALSE)
  }

  selected_sheets <- sheets[sheets %in% years]
  missing_years <- setdiff(years, selected_sheets)
  if (length(missing_years)) {
    warning("No worksheet found for year(s): ",
            paste(missing_years, collapse = ", "), call. = FALSE)
  }
  if (!length(selected_sheets)) {
    stop("No worksheets found for the requested year(s): ",
         paste(years, collapse = ", "), call. = FALSE)
  }

  expected_cols <- c(
    "Date", "DOY", "Temperature deg C Min", "Temperature deg C Max",
    "Air temp Mean", "Temp diff deg C", "Rainfall mm", "Soil 15cm deg C",
    "Soil 45cm deg C", "Average Wind speed Km/h", "RH (%)",
    "Leaf wetness (U)", "Lite totals daily (W/m2)"
  )

  weather <- lapply(selected_sheets, function(sheet) {
    headers <- read_excel(file, sheet = sheet, col_names = FALSE, n_max = 2)
    if (nrow(headers) < 2L || ncol(headers) < 13L) {
      stop("Worksheet '", sheet,
           "' must contain two header rows and at least 13 columns.",
           call. = FALSE)
    }
    headers[is.na(headers)] <- ""
    column_names <- trimws(gsub("\\s+", " ", paste(headers[1, ], headers[2, ])))
    column_names[column_names == "Max"] <- "Temperature deg C Max"

    dat <- read_excel(
      path = file,
      sheet = sheet,
      range = cell_limits(ul = c(3, 1), lr = c(NA, 13)),
      col_types = c("date", rep("text", 12)),
      col_names = column_names,
      .name_repair = "minimal"
    )
    names(dat) <- trimws(names(dat))
    # Ignore trailing workbook notes/summary rows, which have no observation date.
    dat <- dat[!is.na(dat$Date), , drop = FALSE]

    missing_cols <- setdiff(expected_cols, names(dat))
    if (length(missing_cols)) {
      stop("Worksheet '", sheet, "' is missing required column(s): ",
           paste(missing_cols, collapse = ", "), call. = FALSE)
    }
    if (anyDuplicated(names(dat))) {
      stop("Worksheet '", sheet, "' contains duplicated column names.",
           call. = FALSE)
    }

    dat <- dat[expected_cols]
    numeric_cols <- setdiff(expected_cols, "Date")
    dat[numeric_cols] <- lapply(dat[numeric_cols], function(x) {
      suppressWarnings(as.numeric(x))
    })
    dat
  })

  weather <- bind_rows(weather) |>
    mutate(Date = as.Date(.data$Date)) |>
    filter(.data$Date >= start_date, .data$Date <= end_date)

  weather |>
    pivot_longer(
      cols = -c("Date", "DOY"),
      names_to = "variable",
      values_to = "value"
    ) |>
    arrange(.data$variable, .data$Date)
}
