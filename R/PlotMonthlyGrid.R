#' @title PlotMonthlyGrid
#' @author Gareth Burns
#' @param variable A weather variable
#' @description Creates a monthly grid of weather variable
#' @importFrom lubridate day
#' @return A ggplot object.
#' @export

PlotMonthlyGrid <- function(data,
                            variable = c(
                              "Air temp Mean",
                              "Average Wind speed Km/h",
                              "Leaf wetness (U)",
                              "Lite totals daily (W/m2)",
                              "RH (%)",
                              "Rainfall mm",
                              "Soil 15cm deg C",
                              "Soil 45cm deg C",
                              "Temp diff deg C",
                              "temperature_range"
                            ),
                            title = sprintf("Daily %s from %s to %s",
                                            variable,
                                            format(min(data$Date), "%d %b %Y"),
                                            format(max(data$Date), "%d %b %Y")),
                            caption = "Location: Crossnacreevy, Northern Ireland") {

  variable <- match.arg(variable)

  if (variable == "temperature_range") {
    var <-    c("Temperature deg C Min", "Temperature deg C Max")

    data <- data |>
      dplyr::filter(variable %in% var) |>
      pivot_wider(names_from = variable, values_from = value)

    p <-
      ggplot(data, aes(x = day(Date)))

  } else {
    var <- variable

    data <- data |>
      dplyr::filter(variable %in% var)

    p <-
      ggplot(data, aes(x = day(Date), y = value))

  }



  switch(
    variable,

    "Rainfall mm" =
      p <-  p + geom_col(fill = "steelblue"),

    "Leaf wetness (U)" =
      p <-  p + geom_area(
        fill = "forestgreen",
        alpha = 0.6
      ),

    "Lite totals daily (W/m2)" =
      p <-  p + geom_area(
        fill = "goldenrod",
        alpha = 0.6
      ),

    "Air temp Mean" =
      p <-  p + geom_line(colour = "red"),

    "temperature_range" =
      p <-  p + geom_ribbon(
        aes(ymin = `Temperature deg C Min`, ymax = `Temperature deg C Max`),
        fill = "grey80"
      )      +
      geom_line(aes(y = `Temperature deg C Max`), colour = "firebrick") +
      geom_line(aes(y = `Temperature deg C Min`), colour = "dodgerblue")
    ,

    "Average Wind speed Km/h" =
      p <-  p + geom_line(colour = "grey40"),

    "RH (%)" =
      geom_line(colour = "darkcyan"),

    "Soil 15cm deg C" =
      p <-  p + geom_line(colour = "sienna3"),

    "Soil 45cm deg C" =
      p <-  p + geom_line(colour = "saddlebrown"),

    "Temp diff deg C" =
      p <-  p + geom_line(colour = "purple"),

    p <-  p + geom_line()  # default
  )


  p <-  p + facet_wrap(~ month(Date, label = TRUE), ncol = 4) +
    labs(
      title = title,
      x = "Day of month",
      y = variable,
      caption = caption
    ) +
    theme_bw() +
    theme(plot.caption = element_text(
      hjust = 1,
      colour = "grey40",
      size = 9
    ))

  return(p)

}
