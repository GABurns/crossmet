#' @title Monthly Climate Summary Table
#' @author Gareth Burns
#' @description Calculates long-term monthly climatological summaries across
#'   years. Daily observations are summarised within each calendar year and
#'   the resulting yearly monthly values are averaged across years.
#' @param data A data frame containing Date, variable, and value columns.
#' @return A tibble with one row per variable and one column per calendar month.
#' @export
ClimateSummaryTable <- function(data) {
  required_cols <- c("Date", "variable", "value")
  missing_cols <- setdiff(required_cols, names(data))
  if (length(missing_cols)) {
    stop("data is missing required column(s): ",
         paste(missing_cols, collapse = ", "), call. = FALSE)
  }

  yearly_monthly <- data |>
    dplyr::mutate(
      Date = as.Date(.data$Date),
      year = lubridate::year(.data$Date),
      month = lubridate::month(.data$Date, label = TRUE, abbr = TRUE)
    ) |>
    dplyr::group_by(.data$year, .data$month, .data$variable) |>
    dplyr::summarise(
      monthly_value = {
        observed <- .data$value[!is.na(.data$value)]
        if (!length(observed)) NA_real_
        else if (dplyr::first(.data$variable) %in%
                 c("Rainfall mm", "Lite totals daily (W/m2)")) sum(observed)
        else if (dplyr::first(.data$variable) == "Temperature deg C Max") max(observed)
        else if (dplyr::first(.data$variable) == "Temperature deg C Min") min(observed)
        else mean(observed)
      },
      .groups = "drop"
    )

  yearly_monthly |>
    dplyr::group_by(.data$month, .data$variable) |>
    dplyr::summarise(
      climatological_value = {
        observed <- .data$monthly_value[!is.na(.data$monthly_value)]
        if (!length(observed)) NA_real_ else mean(observed)
      },
      .groups = "drop"
    ) |>
    tidyr::pivot_wider(
      names_from = "month",
      values_from = "climatological_value"
    ) |>
    dplyr::arrange(.data$variable)
}
