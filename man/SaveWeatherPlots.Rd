% Generated documentation for SaveWeatherPlots
\name{SaveWeatherPlots}
\alias{SaveWeatherPlots}
\title{Save weather plots}
\usage{
SaveWeatherPlots(
  data,
  plots = c("temperature", "air_temperature", "temperature_difference",
    "rainfall", "soil_temperature", "wind_speed", "relative_humidity",
    "leaf_wetness", "solar_radiation"),
  monthly_grids = TRUE,
  path = getwd(),
  width = 8,
  height = 5,
  dpi = 300,
  device = "png"
)
}
\arguments{
\item{data}{A data frame containing Date, DOY, variable, and value columns.}
\item{plots}{Character vector of plot names to create.}
\item{monthly_grids}{Logical; also save monthly grid plots when TRUE.}
\item{path}{Directory in which to save plots.}
\item{width}{Plot width in inches.}
\item{height}{Plot height in inches.}
\item{dpi}{Image resolution in dots per inch.}
\item{device}{Output image format.}
}
\value{
Invisibly returns the paths of all files created, including monthly grid plots.
}
\description{
Creates selected weather plots and saves them to a specified directory.
Unknown plot names are rejected with an informative error.
}
\author{Gareth Burns}
