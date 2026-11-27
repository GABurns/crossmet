# Plot soil temperature

Creates a time-series plot comparing soil temperature at 15 cm and 45 cm
depth.

## Usage

``` r
SoilTempPlot(
  data,
  title =
    sprintf("Daily Soil Temperature (oC) at 15 and 45cm soil depth from %s to %s",
    format(min(data$Date), "%d %b %Y"), format(max(data$Date), "%d %b %Y")),
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
