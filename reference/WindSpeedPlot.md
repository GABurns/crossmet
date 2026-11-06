# Plot average wind speed

Creates a time-series plot of daily average wind speed.

## Usage

``` r
WindSpeedPlot(
  data,
  title = sprintf("Daily Average Wind Speed (km/h) from %s to %s",
    format(min(data$Date), "%d %b %Y"), format(max(data$Date), "%d %b %Y")),
  caption = "Location: Crossnacreevy, Northern Ireland"
)
```

## Value

A ggplot object.

## Author

Gareth Burns
