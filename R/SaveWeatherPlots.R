#' @title Save weather plots
#' @author Gareth Burns
#' @description Creates selected weather plots and saves them to a specified directory.
#' @param data A data frame containing Date, DOY, variable, and value columns.
#' @param plots Character vector specifying the plots to create. Available
#'   options are "temperature", "air_temperature", "temperature_difference",
#'   "rainfall", "soil_temperature", "wind_speed", "relative_humidity",
#'   "leaf_wetness", and "solar_radiation".
#' @param monthly_grids Logical. If TRUE, also saves monthly grid plots for
#'   each supported weather variable.
#' @param path Directory in which to save plots. Created if necessary.
#' @param width Width of each saved plot in inches. Default is 8.
#' @param height Height of each saved plot in inches. Default is 5.
#' @param dpi Resolution of saved images in dots per inch. Default is 300.
#' @param device Output image format. Default is "png".
#' @return Invisibly returns a character vector containing the paths of all
#'   files created, including monthly grid plots.
#' @import ggplot2
#' @importFrom janitor make_clean_names
#' @export
SaveWeatherPlots <- function(data,
                             plots = c(
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
  required_cols <- c("Date", "DOY", "variable", "value")
  missing_cols <- setdiff(required_cols, names(data))
  if (length(missing_cols)) {
    stop("data is missing required column(s): ",
         paste(missing_cols, collapse = ", "), call. = FALSE)
  }
  if (!length(data$Date) || all(is.na(data$Date))) {
    stop("data$Date must contain at least one valid date.", call. = FALSE)
  }
  if (!is.logical(monthly_grids) || length(monthly_grids) != 1L ||
      is.na(monthly_grids)) {
    stop("monthly_grids must be TRUE or FALSE.", call. = FALSE)
  }

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

  invalid_plots <- setdiff(plots, names(plot_functions))
  if (length(invalid_plots)) {
    stop(
      "Unknown plot(s): ", paste(invalid_plots, collapse = ", "),
      ". Available plots are: ", paste(names(plot_functions), collapse = ", "),
      call. = FALSE
    )
  }
  if (anyDuplicated(plots)) {
    stop("plots must not contain duplicate plot names.", call. = FALSE)
  }

  if (!dir.exists(path) && !dir.create(path, recursive = TRUE)) {
    stop("Could not create output directory: ", path, call. = FALSE)
  }

  date_range <- paste0(
    format(min(as.Date(data$Date), na.rm = TRUE), "%d %b %Y"),
    "_to_",
    format(max(as.Date(data$Date), na.rm = TRUE), "%d %b %Y")
  )
  saved_files <- character()

  for (plot_name in plots) {
    p <- plot_functions[[plot_name]](data)
    filepath <- file.path(path, paste0(plot_name, "_", date_range, ".", device))
    ggsave(
      filename = filepath, plot = p, device = device,
      width = width, height = height, units = "in", dpi = dpi
    )
    saved_files <- c(saved_files, filepath)
  }

  if (monthly_grids) {
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

    for (variable in variables) {
      p <- PlotMonthlyGrid(data, variable = variable)
      filename <- paste0(
        "monthly_grid_", make_clean_names(variable), "_",
        date_range, ".", device
      )
      filepath <- file.path(path, filename)
      ggsave(
        filename = filepath, plot = p, device = device,
        width = width, height = height, units = "in", dpi = dpi
      )
      saved_files <- c(saved_files, filepath)
    }
  }

  invisible(saved_files)
}
