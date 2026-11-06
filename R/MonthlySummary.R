#' @title Monthly Summary
#' @author Gareth Burns
#' @description Creates a monthly summary table
#' @param data A tibble or data.frame containing weather data.
#' @importFrom dplyr mutate group_by summarise case_when first
#' @importFrom tidyr pivot_wider
#' @importFrom lubridate month
#' @return A tibble
#' @export

MonthlySummary <- function(data, ...) {

  data |>
  mutate(month = month(Date, label = TRUE, abbr = TRUE)) |>
  group_by(month, variable) |>
  summarise(
    summary_value = case_when(
      first(variable) %in% c("Rainfall mm", "Lite totals daily (W/m2)") ~ sum(value, na.rm = TRUE),
      first(variable) == "Temperature deg C Max" ~ max(value, na.rm = TRUE),
      first(variable) == "Temperature deg C Min" ~ min(value, na.rm = TRUE),
      TRUE ~ mean(value, na.rm = TRUE)
    ),
    .groups = "drop"
  ) |>
  pivot_wider(names_from = month, values_from = summary_value)

}
