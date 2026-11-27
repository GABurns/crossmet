#' @title Plot relative humidity
#' @author Gareth Burns
#' @description Creates a time-series plot of relative humidity.
#' @param data A long-format weather data frame with Date, DOY, variable,
#'   and value columns.
#' @param title Plot title. Defaults to a title containing the date range.
#' @param caption Plot caption.
#' @return A ggplot2 object.
#' @export
RelativeHumidityPlot <- function(data,
                                 title = sprintf("Daily Relative Humidity from %s to %s",
                                                 format(min(data$Date), "%d %b %Y"),
                                                 format(max(data$Date), "%d %b %Y")),
                                 caption = "Location: Crossnacreevy, Northern Ireland") {
  plot_weather_variable(data, "RH (%)", title, "Relative humidity (%)",
                        caption = caption, colour = "#2CA25F")
}
