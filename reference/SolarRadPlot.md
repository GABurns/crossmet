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

## Arguments

- data:

  A long-format weather data frame with Date, DOY, variable, and value
  columns.

- title:

  Plot title. Defaults to a title containing the date range.

- caption:

  Plot caption.

## Value

A ggplot2 object.

## Author

Gareth Burns
