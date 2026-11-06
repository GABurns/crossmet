#' @title Plot soil temperature
#' @author Gareth Burns
#' @description Creates a time-series plot comparing soil temperature at 15 cm and
#' 45 cm depth.
#' @return A ggplot object.
#' @export

SoilTempPlot <- function(data, title = sprintf("Daily Soil Temperature (oC) at 15 and 45cm soil depth from %s to %s",
                                               format(min(data$Date), "%d %b %Y"),
                                               format(max(data$Date), "%d %b %Y")), caption = "Location: Crossnacreevy, Northern Ireland") {
  variables <- c("Soil 15cm deg C", "Soil 45cm deg C")

  plot_data <- data |>
    filter(.data$variable %in% variables) |>
    mutate(
      Date = as.Date(.data$Date),
      variable = factor(
        .data$variable,
        levels = variables,
        labels = c("15 cm", "45 cm")
      )
    )

  ggplot(plot_data,
         aes(
           x = .data$Date,
           y = .data$value,
           colour = .data$variable
         )) +
    geom_line(linewidth = 0.6, na.rm = TRUE) +
    labs(
      title = title,
      caption = caption,
      x = NULL,
      y = "Soil temperature (°C)",
      colour = "Depth"
    ) +
    scale_colour_manual(values = c("15 cm" = "#D95F0E", "45 cm" = "#756BB1")) +
    scale_x_date(date_labels = "%b %Y") +
    theme_bw() +
    theme(plot.caption = element_text(
      hjust = 1,
      colour = "grey40",
      size = 9
    ))
}
