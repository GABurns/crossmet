#' @title Plot mean air temperature
#' @author Gareth Burns
#' @description Creates a time-series plot of daily mean air temperature.
#' @param data A long-format weather data frame with Date, DOY, variable,
#'   and value columns.
#' @param title Plot title. Defaults to a title containing the date range.
#' @param caption Plot caption.
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
    ylab = "Air temperature (\\u00b0C)",
    colour = "#E6550D",
    caption = caption
  )
}
