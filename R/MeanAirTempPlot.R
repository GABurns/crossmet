#' @title Plot mean air temperature
#' @author Gareth Burns
#' @description Creates a time-series plot of daily mean air temperature.
#' @return A ggplot2 object.
#' @export

MeanAirTempPlot <- function(data,
                            title = sprintf(
                              "Daily Mean Air Temperature from %s to %s",
                              format(min(data$Date), "%d %b %Y"),
                              format(max(data$Date), "%d %b %Y")
                            ),
                            caption = "Location: Crossnacreevy, Northern Ireland") {
  plot_weather_variable(
    data = data,
    variable = "Air temp Mean",
    title = title,
    ylab = "Air temperature (°C)",
    colour = "#E6550D",
    caption
  )
}
