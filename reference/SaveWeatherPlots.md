# Save weather plots

Creates selected weather plots and saves them to a specified directory.
Unknown plot names are rejected with an informative error.

## Usage

``` r
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
```

## Arguments

- data:

  A data frame containing Date, DOY, variable, and value columns.

- plots:

  Character vector of plot names to create.

- monthly_grids:

  Logical; also save monthly grid plots when TRUE.

- path:

  Directory in which to save plots.

- width:

  Plot width in inches.

- height:

  Plot height in inches.

- dpi:

  Image resolution in dots per inch.

- device:

  Output image format.

## Value

Invisibly returns the paths of all files created, including monthly grid
plots.

## Author

Gareth Burns
