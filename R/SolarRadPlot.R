#' @title Plot daily light totals
#' @author Gareth Burns
#' @description Creates a time-series plot of daily light totals.
#' @param data A long-format weather data frame with Date, DOY, variable,
#'   and value columns.
#' @param title Plot title. Defaults to a title containing the date range.
#' @param caption Plot caption.
#' @return A ggplot2 object.
#' @export
SolarRadPlot <- function(data,
                          title = sprintf("Daily Light Total (W/m2) from %s to %s",
                                          format(min(data$Date), "%d %b %Y"),
                                          format(max(data$Date), "%d %b %Y")),
                          caption = "Location: Crossnacreevy, Northern Ireland") {
  plot_weather_variable(
    data = data, variable = "Lite totals daily (W/m2)", title = title,
    ylab = expression("Light (W/m"^2*")"), colour = "#FDAE6B",
    caption = caption
  )
}
