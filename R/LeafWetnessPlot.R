#' @title Plot leaf wetness
#' @author Gareth Burns
#' @description Creates a time-series plot of leaf wetness.
#' @param data A long-format weather data frame with Date, DOY, variable,
#'   and value columns.
#' @param title Plot title. Defaults to a title containing the date range.
#' @param caption Plot caption.
#' @return A ggplot2 object.
#' @export
LeafWetnessPlot <- function(data,
                            title = sprintf("Daily Leaf Wetness from %s to %s",
                                            format(min(data$Date), "%d %b %Y"),
                                            format(max(data$Date), "%d %b %Y")),
                            caption = "Location: Crossnacreevy, Northern Ireland") {
  plot_weather_variable(data, "Leaf wetness (U)", title,
                        "Leaf wetness (U)", caption = caption,
                        colour = "#41AB5D")
}
