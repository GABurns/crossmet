#' @title Plot temperature difference
#' @author Gareth Burns
#' @description Creates a time-series plot of temperature difference.
#' @param data A long-format weather data frame with Date, DOY, variable,
#'   and value columns.
#' @param title Plot title. Defaults to a title containing the date range.
#' @param caption Plot caption.
#' @return A ggplot2 object.
#' @export
TemperatureDifferencePlot <- function(
    data,
    title = sprintf(
      "Daily Temperature Difference from %s to %s",
      format(min(data$Date), "%d %b %Y"),
      format(max(data$Date), "%d %b %Y")
    ),
    caption = "Location: Crossnacreevy, Northern Ireland") {
  plot_weather_variable(
    data = data,
    variable = "Temp diff deg C",
    title = title,
    ylab = "Temperature difference (\\u00b0C)",
    colour = "#756BB1",
    caption = caption
  )
}
