# Plot relative humidity

Creates a time-series plot of relative humidity.

## Usage

``` r
RelativeHumidityPlot(
  data,
  title = sprintf("Daily Relative Humidity from %s to %s", format(min(data$Date),
    "%d %b %Y"), format(max(data$Date), "%d %b %Y")),
  caption = "Location: Crossnacreevy, Northern Ireland"
)
```

## Arguments

- data:

  A long-format weather data frame with Date, DOY, variable, and value
  columns.

- title:

  Plot title. Defaults to a title containing the date range.

- caption:

  Plot caption.

## Value

A ggplot object.

## Author

Gareth Burns
