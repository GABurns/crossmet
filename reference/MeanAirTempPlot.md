# Plot mean air temperature

Creates a time-series plot of daily mean air temperature.

## Usage

``` r
MeanAirTempPlot(
  data,
  title = sprintf("Daily Mean Air Temperature from %s to %s", format(min(data$Date),
    "%d %b %Y"), format(max(data$Date), "%d %b %Y")),
  caption = "Location: Crossnacreevy, Northern Ireland"
)
```

## Value

A ggplot2 object.

## Author

Gareth Burns
