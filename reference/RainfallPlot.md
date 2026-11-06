# title Plot daily rainfall

Creates a column plot showing daily rainfall totals.

## Usage

``` r
RainfallPlot(
  data,
  title = sprintf("Daily Rainfall Total (mm) from %s to %s", format(min(data$Date),
    "%d %b %Y"), format(max(data$Date), "%d %b %Y")),
  caption = "Location: Crossnacreevy, Northern Ireland"
)
```

## Value

A ggplot2 object.

## Author

Gareth Burns

## Examples

``` r
if (FALSE) { # \dontrun{
RainfallPlot(weather)
} # }
```
