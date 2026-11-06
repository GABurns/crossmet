# Save weather plots

Creates selected weather plots and saves them to a specified directory.

## Usage

``` r
SaveWeatherPlots(
  data,
  plots = c("temperature", "air_temperature", "temperature_difference", "rainfall",
    "soil_temperature", "wind_speed", "relative_humidity", "leaf_wetness",
    "solar_radiation"),
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

  A data frame containing weather data in long format. The data must
  contain the columns \`Date\`, \`DOY\`, \`variable\`, and \`value\`.

- plots:

  Character vector specifying the plots to create. Available options are
  \`"temperature"\`, \`"air_temperature"\`,
  \`"temperature_difference"\`, \`"rainfall"\`, \`"soil_temperature"\`,
  \`"wind_speed"\`, \`"relative_humidity"\`, \`"leaf_wetness"\`, and
  \`"solar_rad"\`.

- path:

  Character string giving the directory in which to save the plots. The
  directory will be created if it does not exist.

- width:

  Width of each saved plot in inches. Default is 8.

- height:

  Height of each saved plot in inches. Default is 5.

- dpi:

  Resolution of saved images in dots per inch. Default is 300.

- device:

  Character string specifying the output image format. Default is
  \`"png"\`.

## Value

Invisibly returns a character vector containing the paths of the files
created.

## Author

Gareth Burns

## Examples

``` r
if (FALSE) { # \dontrun{
SaveWeatherPlots(
  weather,
  plots = c(
    "temperature",
    "rainfall",
    "soil_temperature"
  ),
  path = "plots"
)
} # }
```
