# Plot daily light totals

Creates a time-series plot of daily light totals.

## Usage

``` r
SolarRadPlot(
  data,
  title = sprintf("Daily Light Total (W/m2) from %s to %s", format(min(data$Date),
    "%d %b %Y"), format(max(data$Date), "%d %b %Y")),
  caption = "Location: Crossnacreevy, Northern Ireland"
)
```

## Value

A ggplot2 object.

## Author

Gareth Burns
