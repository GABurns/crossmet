#' @title Plot minimum and maximum air temperature
#' @author Gareth Burns
#' @description Creates a time-series plot of daily minimum and maximum temperature.
#' @param data A data frame containing weather data in long format.
#'   The data must contain the columns `Date`, `DOY`, `variable`, and `value`.
#' @return A ggplot2 object.
#' @examples
#' \dontrun{
#' TemperaturePlot(weather)
#' }
#'
#' @export
TemperaturePlot <- function(data, title = sprintf("Daily Air Temperature Range from %s to %s",
                                                  format(min(data$Date), "%d %b %Y"),
                                                  format(max(data$Date), "%d %b %Y")),
                            caption = "Location: Crossnacreevy, Northern Ireland") {

  variables <- c(
    "Temperature deg C Min",
    "Temperature deg C Max"
  )

  plot_data <- data |>
    filter(.data$variable %in% variables) |>
    mutate(
      Date = as.Date(.data$Date),
      variable = factor(
        .data$variable,
        levels = variables,
        labels = c("Minimum", "Maximum")
      )
    )

  ggplot(
    plot_data,
    aes(
      x = .data$Date,
      y = .data$value,
      colour = .data$variable
    )
  ) +
    geom_line(
      linewidth = 0.6,
      na.rm = TRUE
    ) +
    labs(
      title = title,
      caption = caption,
      x = NULL,
      y = "Temperature (°C)",
      colour = "Temperature"
    ) +
    scale_colour_manual(
      values = c(
        "Minimum" = "#2C7FB8",
        "Maximum" = "#D7301F"
      )
    ) +
    scale_x_date(
      date_labels = "%b %Y"
    ) +
    theme_minimal()
}
