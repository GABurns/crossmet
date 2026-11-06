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

## Value

A ggplot object.

## Author

Gareth Burns
