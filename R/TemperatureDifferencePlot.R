#' @title Plot temperature difference
#' @author Gareth Burns
#' @description Creates a time-series plot of temperature difference.
#' @return A ggplot2 object.
#' @export
#'
TemperatureDifferencePlot <- function(data, title = sprintf("Daily Temperature Difference from %s to %s",
                                                            format(min(data$Date), "%d %b %Y"),
                                                            format(max(data$Date), "%d %b %Y")), caption = "Location: Crossnacreevy, Northern Ireland") {

  plot_weather_variable(
    data = data,
    variable = "Temp diff deg C",
    title = "Temperature Difference",
    ylab = "Temperature difference (°C)",
    colour = "#756BB1",
    caption = caption
  )
}
