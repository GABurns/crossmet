#' @title Plot leaf wetness
#' @author Gareth Burns
#' @description Creates a time-series plot of leaf wetness.
#' @return A ggplot object.
#' @export

LeafWetnessPlot <- function(data,
                            title = sprintf("Daily Leaf Wetness from %s to %s",
                                            format(min(data$Date), "%d %b %Y"),
                                            format(max(data$Date), "%d %b %Y")),
                            caption = "Location: Crossnacreevy, Northern Ireland") {
  plot_weather_variable(
    data = data,
    variable = "Leaf wetness (U)",
    title = title,
    ylab = "Leaf wetness (U)",
    colour = "#41AB5D",
    caption = caption
  )
}
