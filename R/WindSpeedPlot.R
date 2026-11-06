#' @title Plot average wind speed
#' @author Gareth Burns
#' @description Creates a time-series plot of daily average wind speed.
#' @return A ggplot object.
#' @export


WindSpeedPlot <- function(data,
                          title = sprintf(
                            "Daily Average Wind Speed (km/h) from %s to %s",
                            format(min(data$Date), "%d %b %Y"),
                            format(max(data$Date), "%d %b %Y")
                          ),
                          caption = "Location: Crossnacreevy, Northern Ireland") {
  plot_weather_variable(
    data = data,
    variable = "Average Wind speed Km/h",
    title = title,
    ylab = "Wind speed (km/h)",
    colour = "#636363",
    caption = caption
  )
}
