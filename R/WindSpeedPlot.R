#' @title Plot average wind speed
#' @author Gareth Burns
#' @description Creates a time-series plot of daily average wind speed.
#' @param data A long-format weather data frame with Date, DOY, variable,
#'   and value columns.
#' @param title Plot title. Defaults to a title containing the date range.
#' @param caption Plot caption.
#' @return A ggplot2 object.
#' @export
WindSpeedPlot <- function(data,
                          title = sprintf(
                            "Daily Average Wind Speed (km/h) from %s to %s",
                            format(min(data$Date), "%d %b %Y"),
                            format(max(data$Date), "%d %b %Y")
                          ),
                          caption = "Location: Crossnacreevy, Northern Ireland") {
  plot_weather_variable(data, "Average Wind speed Km/h", title,
                        "Wind speed (km/h)", caption = caption,
                        colour = "#636363")
}
