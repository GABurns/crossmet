#' @title Plot soil temperature
#' @author Gareth Burns
#' @description Creates a time-series plot comparing soil temperature at 15 cm and
#'   45 cm depth.
#' @param data A long-format weather data frame with Date, DOY, variable,
#'   and value columns.
#' @param title Plot title. Defaults to a title containing the date range.
#' @param caption Plot caption.
#' @return A ggplot2 object.
#' @export
SoilTempPlot <- function(data,
                         title = sprintf(
                           "Daily Soil Temperature (deg C) at 15 and 45 cm depth from %s to %s",
                           format(min(data$Date), "%d %b %Y"),
                           format(max(data$Date), "%d %b %Y")
                         ),
                         caption = "Location: Crossnacreevy, Northern Ireland") {
  variables <- c("Soil 15cm deg C", "Soil 45cm deg C")
  plot_data <- data |>
    dplyr::filter(.data$variable %in% variables) |>
    dplyr::mutate(
      Date = as.Date(.data$Date),
      variable = factor(
        .data$variable,
        levels = variables,
        labels = c("15 cm", "45 cm")
      )
    )

  ggplot2::ggplot(
    plot_data,
    ggplot2::aes(x = .data$Date, y = .data$value, colour = .data$variable)
  ) +
    ggplot2::geom_line(linewidth = 0.6, na.rm = TRUE) +
    ggplot2::labs(
      title = title, caption = caption, x = NULL,
      y = "Soil temperature (\\u00b0C)", colour = "Depth"
    ) +
    ggplot2::scale_colour_manual(
      values = c("15 cm" = "#D95F0E", "45 cm" = "#756BB1")
    ) +
    ggplot2::scale_x_date(date_labels = "%b %Y") +
    ggplot2::theme_bw() +
    ggplot2::theme(plot.caption = ggplot2::element_text(
      hjust = 1, colour = "grey40", size = 9
    ))
}
