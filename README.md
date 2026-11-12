# crossmet <img src="man/figures/logo.svg" align="right" height="139" alt="crossmet hexagonal weather logo" />

<!-- badges: start -->

[![R-CMD-check](https://github.com/GABurns/crossmet/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/GABurns/crossmet/actions/workflows/R-CMD-check.yaml)
[![GitHub version](https://img.shields.io/github/r-package/v/GABurns/crossmet)](https://github.com/GABurns/crossmet)
[![License](https://img.shields.io/github/license/GABurns/crossmet)](https://github.com/GABurns/crossmet)

<!-- badges: end -->

**crossmet** provides tools for importing, summarising and visualising daily
meteorological observations from the AFBI Crossnacreevy weather station in
Northern Ireland.

The package reads annual worksheets from an Excel workbook, reshapes the
observations into a tidy long-format data frame, produces year-specific monthly
summaries and long-term monthly climate summaries, and creates weather plots.

## Installation

Install the development version from GitHub:

```r
install.packages("pak")
pak::pak("GABurns/crossmet")
```

## Import weather observations

\`ImportWeather()\` reads the worksheets needed for the requested date range.
Worksheets are expected to be named with their four-digit year (for example,
\`2023\`) and to follow the Crossnacreevy workbook layout.

```r
library(crossmet)

weather <- ImportWeather(
  file = "data/crossnacreevy_weather.xlsx",
  start_date = "2020-01-01",
  end_date = "2024-12-31"
)

head(weather)
```

The returned data frame contains \`Date\`, \`DOY\`, \`variable\` and \`value\`
columns, with one row per date and weather variable.

## Monthly summaries

\`MonthlySummaryTable()\` calculates monthly values separately for each year.
Rainfall and daily solar-radiation totals are summed; daily maximum temperature
is represented by its monthly maximum; daily minimum temperature by its
monthly minimum; and other variables by their monthly mean.

```r
yearly_months <- MonthlySummaryTable(weather)
```

\`ClimateSummaryTable()\` calculates long-term monthly climatological values.
It first calculates the relevant monthly statistic for each year, then averages
those yearly monthly values across the available years. This means rainfall
climatology is the mean of annual monthly rainfall totals, rather than the
average daily rainfall.

```r
climate_normals <- ClimateSummaryTable(weather)
```

Missing observations are excluded from calculations. A yearly monthly
statistic is \`NA\` when that group has no observed values; a climatological
average is \`NA\` when all years are missing for that month and variable.

## Visualise weather data

The plotting functions return ggplot objects and can be customised with normal
ggplot2 layers.

```r
PlotMonthlyGrid(weather, variable = "RH (%)")
RainfallPlot(weather)
TemperaturePlot(weather)
```

To save a selection of plots and the monthly grid plots:

```r
saved_files <- SaveWeatherPlots(
  weather,
  plots = c("temperature", "rainfall", "relative_humidity"),
  monthly_grids = TRUE,
  path = "outputs/weather-plots"
)

saved_files
```

The function returns the paths of all files it creates, including monthly grid
images.

## Input workbook requirements

- Each worksheet represents one calendar year and is named using that year.
- The workbook contains two header rows followed by daily observations.
- The expected weather columns are Date, DOY, minimum and maximum temperature,
  mean air temperature, temperature difference, rainfall, soil temperatures,
  average wind speed, relative humidity, leaf wetness and daily solar radiation.
- Date values must be readable by readxl as Excel dates.

See the function help pages for complete argument details:

```r
?ImportWeather
?MonthlySummaryTable
?ClimateSummaryTable
?PlotMonthlyGrid
?SaveWeatherPlots
```



The package uses testthat edition 3.
