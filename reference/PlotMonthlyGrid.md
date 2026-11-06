# PlotMonthlyGrid

Creates a monthly grid of weather variable

## Usage

``` r
PlotMonthlyGrid(
  data,
  variable = c("Air temp Mean", "Average Wind speed Km/h", "Leaf wetness (U)",
    "Lite totals daily (W/m2)", "RH (%)", "Rainfall mm", "Soil 15cm deg C",
    "Soil 45cm deg C", "Temp diff deg C", "temperature_range"),
  title = sprintf("Daily %s from %s to %s", variable, format(min(data$Date),
    "%d %b %Y"), format(max(data$Date), "%d %b %Y")),
  caption = "Location: Crossnacreevy, Northern Ireland"
)
```

## Arguments

- variable:

  A weather variable

## Value

A ggplot object.

## Author

Gareth Burns
