#' @title Internal weather plotting helper
#' @description Creates a consistent plot for a selected weather variable.
#' @param data A long-format weather data frame.
#' @param variable Name of the weather variable to plot.
#' @param title Plot title.
#' @param ylab Y-axis label.
#' @param caption Plot caption.
#' @param colour Line or column colour.
#' @param geom Plot geometry ("line" or "column").
#' @return A ggplot2 object.
#' @import ggplot2
#' @importFrom dplyr filter mutate arrange
#' @noRd
plot_weather_variable <- function(data,
                                  variable,
                                  title,
                                  ylab,
                                  caption = "Location: Crossnacreevy, Northern Ireland",
                                  colour = "#2C7FB8",
                                  geom = "line") {
  required_cols <- c("Date", "DOY", "variable", "value")
  missing_cols <- setdiff(required_cols, names(data))
  if (length(missing_cols)) {
    stop("Data is missing required column(s): ",
         paste(missing_cols, collapse = ", "), call. = FALSE)
  }
  if (!variable %in% data$variable) {
    stop("Variable '", variable, "' was not found in the data.", call. = FALSE)
  }

  plot_data <- data |>
    filter(.data$variable == .env$variable) |>
    mutate(Date = as.Date(.data$Date))

  p <- ggplot(plot_data, aes(x = .data$Date, y = .data$value))
  if (geom == "line") {
    p <- p + geom_line(colour = colour, linewidth = 0.6, na.rm = TRUE)
  }
  if (geom == "column") {
    p <- p + geom_col(fill = colour, width = 1, na.rm = TRUE)
  }
  p +
    labs(title = title, x = NULL, y = ylab, caption = caption) +
    scale_x_date(date_labels = "%b %Y") +
    theme_bw() +
    theme(plot.caption = element_text(hjust = 1, colour = "grey40", size = 9))
}
