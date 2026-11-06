# Plot leaf wetness

Creates a time-series plot of leaf wetness.

## Usage

``` r
LeafWetnessPlot(
  data,
  title = sprintf("Daily Leaf Wetness from %s to %s", format(min(data$Date),
    "%d %b %Y"), format(max(data$Date), "%d %b %Y")),
  caption = "Location: Crossnacreevy, Northern Ireland"
)
```

## Value

A ggplot object.

## Author

Gareth Burns
