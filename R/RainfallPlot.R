#' @title Plot daily rainfall
#' @author Gareth Burns
#' @description Creates a column plot showing daily rainfall totals.
#' @param data A long-format weather data frame with Date, DOY, variable,
#'   and value columns.
#' @param title Plot title. Defaults to a title containing the date range.
#' @param caption Plot caption.
#' @return A ggplot2 object.
#' @examples
#' \\dontrun{
#' RainfallPlot(weather)
#' }
#' @export
RainfallPlot <- function(data,
                         title = sprintf("Daily Rainfall Total (mm) from %s to %s",
                                         format(min(data$Date), "%d %b %Y"),
                                         format(max(data$Date), "%d %b %Y")),
                         caption = "Location: Crossnacreevy, Northern Ireland") {
  plot_weather_variable(
    data = data, variable = "Rainfall mm", title = title,
    ylab = "Rainfall (mm)", colour = "#3182BD",
    geom = "column", caption = caption
  )
}
