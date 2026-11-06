# Plot minimum and maximum air temperature

Creates a time-series plot of daily minimum and maximum temperature.

## Usage

``` r
TemperaturePlot(
  data,
  title = sprintf("Daily Air Temperature Range from %s to %s", format(min(data$Date),
    "%d %b %Y"), format(max(data$Date), "%d %b %Y")),
  caption = "Location: Crossnacreevy, Northern Ireland"
)
```

## Arguments

- data:

  A data frame containing weather data in long format. The data must
  contain the columns \`Date\`, \`DOY\`, \`variable\`, and \`value\`.

## Value

A ggplot2 object.

## Author

Gareth Burns

## Examples

``` r
if (FALSE) { # \dontrun{
TemperaturePlot(weather)
} # }
```
