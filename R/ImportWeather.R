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
#'   object or a character string that can be converted to a date using
#'   `as.Date()`, e.g. `"2023-01-01"`.
#' @param end_date End date of the period to import. Either a `Date`
#'   object or a character string that can be converted to a date using
#'   `as.Date()`, e.g. `"2025-12-31"`.
#'
#' @return A tibble in long format with four columns:
#' \describe{
#'   \item{date}{Observation date.}
#'   \item{DOY}{Day of year.}
#'   \item{variable}{Weather variable measured.}
#'   \item{value}{Observed value.}
#' }
#'
#' @details
#' Only worksheets corresponding to years between `start_date` and
#' `end_date` are read. For example, a request from `"2023-06-01"` to
#' `"2025-04-30"` will attempt to read the 2023, 2024 and 2025 worksheets.
#'
#' After the worksheets have been combined, observations outside the
#' requested date range are removed.
#'
#' @examples
#' \dontrun{
#' weather <- import_weather(
#'   file = "weather.xlsx",
#'   start_date = "2022-01-01",
#'   end_date = "2025-12-31"
#' )
#'
#' weather
#' }
#' @importFrom readxl excel_sheets read_excel cell_limits
#' @importFrom dplyr filter bind_rows mutate arrange
#' @importFrom tidyr pivot_longer
#' @export
ImportWeather <- function(file,
                          start_date = "2013-01-01",
                          end_date = Sys.Date()) {

  # Check file exists
  if (!file.exists(file)) {
    stop("Excel file does not exist: ", file, call. = FALSE)
  }

  # Convert dates
  start_date <- as.Date(start_date)
  end_date   <- as.Date(end_date)

  if (is.na(start_date) || is.na(end_date)) {
    stop("`start_date` and `end_date` must be valid dates.", call. = FALSE)
  }

  if (start_date > end_date) {
    stop("`start_date` must be earlier than or equal to `end_date`.",
         call. = FALSE)
  }

  # Determine years required
  years <- seq(as.integer(format(start_date, "%Y")), as.integer(format(end_date, "%Y")))

  years <- as.character(years)

  # Read workbook metadata and report malformed workbooks clearly
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

  # Select sheets corresponding to requested years
  selected_sheets <- sheets[sheets %in% years]

  # Ensure the required years are present
  missing_years <- setdiff(years, selected_sheets)

  if (length(missing_years) > 0) {
    warning("No worksheet found for year(s): ",
            paste(missing_years, collapse = ", "),
            call. = FALSE)
  }

  if (!length(selected_sheets)) {
    stop(
      "No worksheets found for the requested year(s): ",
      paste(years, collapse = ", "),
      call. = FALSE
    )
  }

  # Expected Excel columns
  expected_cols <- c(
    "Date",
    "DOY",
    "Temperature deg C Min",
    "Temperature deg C Max",
    "Air temp Mean",
    "Temp diff deg C",
    "Rainfall mm",
    "Soil 15cm deg C",
    "Soil 45cm deg C",
    "Average Wind speed Km/h",
    "RH (%)",
    "Leaf wetness (U)",
    "Lite totals daily (W/m2)"
  )

  # Read each year
  weather <- lapply(selected_sheets, function(sheet) {
    # Column names are split across first 2 rows
    headers <- read_excel(file,
                          sheet = sheet,
                          col_names = FALSE,
                          n_max = 2)

    if (nrow(headers) < 2L || ncol(headers) < 13L) {
      stop(
        "Worksheet '", sheet,
        "' must contain two header rows and at least 13 columns.",
        call. = FALSE
      )
    }

    headers[is.na(headers)] <- ""

    column_names <- paste(headers[1, ], headers[2, ])

    column_names <- gsub("\\s+", " ", column_names)
    column_names <- trimws(column_names)

    column_names[column_names == "Max"] <- "Temperature deg C Max"

    dat <- read_excel(
      path = file,
      sheet = sheet,
      range = cell_limits(
        ul = c(3, 1),
        # Row 3, column A
        lr = c(NA, 13) # Last row, column M
      ),
      col_types = c("date", rep("numeric", 12)),
      col_names = column_names,
      .name_repair = "minimal"
    )

    # Remove spaces around column names
    names(dat) <- trimws(names(dat))

    # Check required columns before selecting them. A warning followed by
    # dat[expected_cols] would otherwise fail with an unhelpful subscript error.
    missing_cols <- setdiff(expected_cols, names(dat))

    if (length(missing_cols) > 0) {
      stop(
        "Worksheet '", sheet, "' is missing required column(s): ",
        paste(missing_cols, collapse = ", "),
        call. = FALSE
      )
    }

    if (anyDuplicated(names(dat))) {
      stop("Worksheet '", sheet, "' contains duplicated column names.",
           call. = FALSE)
    }

    dat[expected_cols]
  })

  # Combine years
  weather <- bind_rows(weather)

  # Filter date range
  weather <- weather |>
    mutate(Date = as.Date(.data$Date)) |>
    filter(.data$Date >= start_date, .data$Date <= end_date)

  # Convert weather variables to long format
  weather <- pivot_longer(
    weather,
    cols = -c("Date", "DOY"),
    names_to = "variable",
    values_to = "value"
  ) |>
    arrange(.data$variable, .data$Date)

  return(weather)
}
