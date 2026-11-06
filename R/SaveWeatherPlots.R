#' @title Save weather plots
#' @author Gareth Burns
#' @description Creates selected weather plots and saves them to a specified directory.
#' @param data A data frame containing weather data in long format.
#'   The data must contain the columns `Date`, `DOY`, `variable`, and `value`.
#' @param plots Character vector specifying the plots to create. Available
#'   options are `"temperature"`, `"air_temperature"`,
#'   `"temperature_difference"`, `"rainfall"`, `"soil_temperature"`,
#'   `"wind_speed"`, `"relative_humidity"`, `"leaf_wetness"`, and `"solar_rad"`.
#' @param path Character string giving the directory in which to save
#'   the plots. The directory will be created if it does not exist.
#' @param width Width of each saved plot in inches. Default is 8.
#' @param height Height of each saved plot in inches. Default is 5.
#' @param dpi Resolution of saved images in dots per inch.
#'   Default is 300.
#' @param device Character string specifying the output image format.
#'   Default is `"png"`.
#' @return Invisibly returns a character vector containing the paths
#'   of the files created.
#' @import ggplot2
#' @examples
#' \dontrun{
#' SaveWeatherPlots(
#'   weather,
#'   plots = c(
#'     "temperature",
#'     "rainfall",
#'     "soil_temperature"
#'   ),
#'   path = "plots"
#' )
#' }
#' @importFrom janitor make_clean_names
#' @export

SaveWeatherPlots <- function(data,
                             plots =   c(
                               "temperature",
                               "air_temperature",
                               "temperature_difference",
                               "rainfall",
                               "soil_temperature",
                               "wind_speed",
                               "relative_humidity",
                               "leaf_wetness",
                               "solar_radiation"
                             ),
                             monthly_grids = TRUE,
                             path = getwd(),
                             width = 8,
                             height = 5,
                             dpi = 300,
                             device = "png") {
  # Map plot names to plotting functions
  plot_functions <- list(
    temperature = TemperaturePlot,
    air_temperature = MeanAirTempPlot,
    temperature_difference = TemperatureDifferencePlot,
    rainfall = RainfallPlot,
    soil_temperature = SoilTempPlot,
    wind_speed = WindSpeedPlot,
    relative_humidity = RelativeHumidityPlot,
    leaf_wetness = LeafWetnessPlot,
    solar_radiation = SolarRadPlot
  )

  # Check requested plots
  invalid_plots <- setdiff(plots, names(plot_functions))

  if (length(invalid_plots) > 0) {
    warning(
      "Unknown plot(s): ",
      paste(invalid_plots, collapse = ", "),
      ". Available plots are: ",
      paste(names(plot_functions), collapse = ", "),
      call. = FALSE
    )
  }

  # Create output directory
  if (!dir.exists(path)) {
    dir.create(path, recursive = TRUE)
  }

  saved_files <- character(length(plots))

  # Create and save each requested plot
  for (i in seq_along(plots)) {
    plot_name <- sprintf("%s_%s_to_%s",
                         plots[[i]],
                         format(min(data$Date), "%d %b %Y"),
                         format(max(data$Date), "%d %b %Y"))

    plot_function <- plot_functions[[plots[[i]]]]

    p <- plot_function(data)

    filename <- paste0(plot_name, ".", device)

    filepath <- file.path(path, filename)

    ggsave(
      filename = filepath,
      plot = p,
      device = device,
      width = width,
      height = height,
      units = "in",
      dpi = dpi
    )

    saved_files[[i]] <- filepath
  }

  if (isTRUE(monthly_grids)) {
    variables <- c(
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
    )


    for (j in variables) {
      plot_name <- sprintf(
        "monthly_grid_%s_%s_to_%s",
        j,
        format(min(data$Date), "%d %b %Y"),
        format(max(data$Date), "%d %b %Y")
      )

      p <- PlotMonthlyGrid(data, variable = j)

      filename <- paste0(make_clean_names(plot_name), ".", device)

      filepath <- file.path(path, filename)

      ggsave(
        filename = filepath,
        plot = p,
        device = device,
        width = width,
        height = height,
        units = "in",
        dpi = dpi
      )
    }


  }

  invisible(saved_files)
}
