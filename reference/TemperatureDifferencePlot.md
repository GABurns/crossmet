# Plot temperature difference

Creates a time-series plot of temperature difference.

## Usage

``` r
TemperatureDifferencePlot(
  data,
  title = sprintf("Daily Temperature Difference from %s to %s", format(min(data$Date),
    "%d %b %Y"), format(max(data$Date), "%d %b %Y")),
  caption = "Location: Crossnacreevy, Northern Ireland"
)
```

## Value

A ggplot2 object.

## Author

Gareth Burns
