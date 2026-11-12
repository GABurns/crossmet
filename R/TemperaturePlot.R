#' @title Plot minimum and maximum air temperature
#' @author Gareth Burns
#' @description Creates a time-series plot of daily minimum and maximum temperature.
#' @param data A long-format weather data frame with Date, DOY, variable,
#'   and value columns.
#' @param title Plot title. Defaults to a title containing the date range.
#' @param caption Plot caption.
#' @return A ggplot2 object.
#' @examples
#' \\dontrun{
#' TemperaturePlot(weather)
#' }
#' @export
TemperaturePlot <- function(
    data,
    title = sprintf(
      "Daily Air Temperature Range from %s to %s",
      format(min(data$Date), "%d %b %Y"),
      format(max(data$Date), "%d %b %Y")
    ),
    caption = "Location: Crossnacreevy, Northern Ireland") {
  variables <- c("Temperature deg C Min", "Temperature deg C Max")
  plot_data <- data |>
    dplyr::filter(.data$variable %in% variables) |>
    dplyr::mutate(
      Date = as.Date(.data$Date),
      variable = factor(
        .data$variable,
        levels = variables,
        labels = c("Minimum", "Maximum")
      )
    )

  ggplot2::ggplot(
    plot_data,
    ggplot2::aes(x = .data$Date, y = .data$value, colour = .data$variable)
  ) +
    ggplot2::geom_line(linewidth = 0.6, na.rm = TRUE) +
    ggplot2::labs(
      title = title, caption = caption, x = NULL,
      y = "Temperature (\\u00b0C)", colour = "Temperature"
    ) +
    ggplot2::scale_colour_manual(
      values = c("Minimum" = "#2C7FB8", "Maximum" = "#D7301F")
    ) +
    ggplot2::scale_x_date(date_labels = "%b %Y") +
    ggplot2::theme_minimal()
}
