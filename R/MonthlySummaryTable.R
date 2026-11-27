#' @title Monthly Summary Table
#' @author Gareth Burns
#' @description Creates monthly weather summaries separately for each year.
#' @param data A data frame containing Date, variable, and value columns.
#' @return A tibble with one row per year and variable, and one column per month.
#' @importFrom dplyr mutate group_by summarise
#' @importFrom tidyr pivot_wider
#' @importFrom lubridate month year
#' @export
MonthlySummaryTable <- function(data, ...) {
  required_cols <- c("Date", "variable", "value")
  missing_cols <- setdiff(required_cols, names(data))
  if (length(missing_cols)) {
    stop("data is missing required column(s): ",
         paste(missing_cols, collapse = ", "), call. = FALSE)
  }

  data |>
    dplyr::mutate(
      Date = as.Date(.data$Date),
      year = lubridate::year(.data$Date),
      month = lubridate::month(.data$Date, label = TRUE, abbr = TRUE)
    ) |>
    dplyr::group_by(.data$year, .data$month, .data$variable) |>
    dplyr::summarise(
      summary_value = {
        observed <- .data$value[!is.na(.data$value)]
        if (!length(observed)) NA_real_
        else if (dplyr::first(.data$variable) %in%
                 c("Rainfall mm", "Lite totals daily (W/m2)")) sum(observed)
        else if (dplyr::first(.data$variable) == "Temperature deg C Max") max(observed)
        else if (dplyr::first(.data$variable) == "Temperature deg C Min") min(observed)
        else mean(observed)
      },
      .groups = "drop"
    ) |>
    tidyr::pivot_wider(names_from = "month", values_from = "summary_value") |>
    dplyr::arrange(.data$year, .data$variable)
}
