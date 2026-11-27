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
