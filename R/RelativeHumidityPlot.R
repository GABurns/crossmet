#' @title Plot relative humidity
#' @author Gareth Burns
#' @description Creates a time-series plot of relative humidity.
#' @return A ggplot object.
#'
#' @export

RelativeHumidityPlot <- function(data,
                                 title = sprintf("Daily Relative Humidity from %s to %s",
                                                 format(min(data$Date), "%d %b %Y"),
                                                 format(max(data$Date), "%d %b %Y")),
                                 caption = "Location: Crossnacreevy, Northern Ireland") {
  plot_weather_variable(
    data = data,
    variable = "RH (%)",
    title = title,
    ylab = "Relative humidity (%)",
    colour = "#2CA25F",
    caption = caption
  )
}
