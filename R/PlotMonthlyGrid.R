#' @title PlotMonthlyGrid
#' @author Gareth Burns
#' @param data A data frame containing Date, variable, and value columns.
#' @param variable A weather variable to plot. Use "temperature_range" to
#'   display daily minimum and maximum temperatures.
#' @param title Plot title. Defaults to a title containing the selected variable
#'   and date range.
#' @param caption Plot caption.
#' @description Creates a faceted monthly grid of a daily weather variable.
#' @return A ggplot object.
#' @importFrom lubridate day month
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
                            title = NULL,
                            caption = "Location: Crossnacreevy, Northern Ireland") {

  required_cols <- c("Date", "variable", "value")
  missing_cols <- setdiff(required_cols, names(data))
  if (length(missing_cols)) {
    stop("data is missing required column(s): ",
         paste(missing_cols, collapse = ", "), call. = FALSE)
  }

  if (!inherits(data$Date, "Date")) {
    data$Date <- as.Date(data$Date)
  }
  if (all(is.na(data$Date))) {
    stop("data$Date must contain at least one valid date.", call. = FALSE)
  }

  variable <- match.arg(variable)

  if (variable == "temperature_range") {
    temperature_variables <- c("Temperature deg C Min", "Temperature deg C Max")
    missing_variables <- setdiff(temperature_variables, unique(data$variable))
    if (length(missing_variables)) {
      stop("data is missing temperature range variable(s): ",
           paste(missing_variables, collapse = ", "), call. = FALSE)
    }

    plot_data <- data |>
      dplyr::filter(.data$variable %in% temperature_variables) |>
      tidyr::pivot_wider(names_from = "variable", values_from = "value")

    p <- ggplot(plot_data, aes(x = day(.data$Date)))
  } else {
    plot_data <- data |>
      dplyr::filter(.data$variable == variable)

    if (!nrow(plot_data)) {
      stop("No observations found for variable: ", variable, call. = FALSE)
    }
    p <- ggplot(plot_data, aes(x = day(.data$Date), y = .data$value))
  }

  if (is.null(title)) {
    title <- sprintf(
      "Daily %s from %s to %s",
      variable,
      format(min(plot_data$Date, na.rm = TRUE), "%d %b %Y"),
      format(max(plot_data$Date, na.rm = TRUE), "%d %b %Y")
    )
  }

  p <- switch(
    variable,
    "Rainfall mm" = p + geom_col(fill = "steelblue"),
    "Leaf wetness (U)" = p + geom_area(fill = "forestgreen", alpha = 0.6),
    "Lite totals daily (W/m2)" = p + geom_area(fill = "goldenrod", alpha = 0.6),
    "Air temp Mean" = p + geom_line(colour = "red"),
    "temperature_range" = p +
      geom_ribbon(
        aes(ymin = .data[["Temperature deg C Min"]],
            ymax = .data[["Temperature deg C Max"]]),
        fill = "grey80"
      ) +
      geom_line(aes(y = .data[["Temperature deg C Max"]]), colour = "firebrick") +
      geom_line(aes(y = .data[["Temperature deg C Min"]]), colour = "dodgerblue"),
    "Average Wind speed Km/h" = p + geom_line(colour = "grey40"),
    "RH (%)" = p + geom_line(colour = "darkcyan"),
    "Soil 15cm deg C" = p + geom_line(colour = "sienna3"),
    "Soil 45cm deg C" = p + geom_line(colour = "saddlebrown"),
    "Temp diff deg C" = p + geom_line(colour = "purple"),
    p + geom_line()
  )

  p +
    facet_wrap(~ lubridate::month(Date, label = TRUE), ncol = 4) +
    labs(title = title, x = "Day of month", y = variable, caption = caption) +
    theme_bw() +
    theme(plot.caption = element_text(
      hjust = 1, colour = "grey40", size = 9
    ))
}
