% Generated documentation for PlotMonthlyGrid
\name{PlotMonthlyGrid}
\alias{PlotMonthlyGrid}
\title{PlotMonthlyGrid}
\usage{
PlotMonthlyGrid(
  data,
  variable = c("Air temp Mean", "Average Wind speed Km/h", "Leaf wetness (U)",
    "Lite totals daily (W/m2)", "RH (\%)", "Rainfall mm", "Soil 15cm deg C",
    "Soil 45cm deg C", "Temp diff deg C", "temperature_range"),
  title = NULL,
  caption = "Location: Crossnacreevy, Northern Ireland"
)
}
\arguments{
\item{data}{A data frame containing Date, variable, and value columns.}
\item{variable}{A weather variable to plot. Use "temperature_range" to
display daily minimum and maximum temperatures.}
\item{title}{Plot title. Defaults to a title containing the selected variable
and date range.}
\item{caption}{Plot caption.}
}
\value{
A ggplot object.
}
\description{
Creates a faceted monthly grid of a daily weather variable.
}
\author{Gareth Burns}
