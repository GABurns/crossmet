# PlotMonthlyGrid

Creates a faceted monthly grid of a daily weather variable.

## Usage

``` r
PlotMonthlyGrid(
  data,
  variable = c("Air temp Mean", "Average Wind speed Km/h", "Leaf wetness (U)",
    "Lite totals daily (W/m2)", "RH (%)", "Rainfall mm", "Soil 15cm deg C",
    "Soil 45cm deg C", "Temp diff deg C", "temperature_range"),
  title = NULL,
  caption = "Location: Crossnacreevy, Northern Ireland"
)
```

## Arguments

- data:

  A data frame containing Date, variable, and value columns.

- variable:

  A weather variable to plot. Use "temperature_range" to display daily
  minimum and maximum temperatures.

- title:

  Plot title. Defaults to a title containing the selected variable and
  date range.

- caption:

  Plot caption.

## Value

A ggplot object.

## Author

Gareth Burns
