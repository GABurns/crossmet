# Weather data from Crossnacreevy, made easier to explore

![crossmet hexagonal weather logo](reference/figures/logo.svg)

**crossmet** is an R package for importing, summarising and visualising
daily meteorological observations from the AFBI Crossnacreevy weather
station in Northern Ireland.

Use the package to move from annual Excel worksheets to tidy
observations, year-by-year monthly summaries, long-term monthly climate
summaries and publication-ready plots.

### Import

Read the relevant annual worksheets, validate the workbook structure and
return a tidy long-format data frame.

[Importing
guide](https://gaburns.github.io/crossmet/articles/importing-data.md)

### Summarise

Compare individual years with \`MonthlySummaryTable()\` or calculate
monthly climate normals with \`ClimateSummaryTable()\`.

[Summary
guide](https://gaburns.github.io/crossmet/articles/summary-tables.md)

### Visualise

Explore daily time series and a calendar-style grid of each month’s
daily weather observations.

[Graph
gallery](https://gaburns.github.io/crossmet/articles/visualisations.md)

## Start here

``` r

install.packages("pak")
pak::pak("GABurns/crossmet")

library(crossmet)

weather <- ImportWeather(
  file = "path/to/crossnacreevy.xlsx",
  start_date = "2020-01-01",
  end_date = "2024-12-31"
)

monthly <- MonthlySummaryTable(weather)
climate <- ClimateSummaryTable(weather)

RainfallPlot(weather)
```

The workbook is expected to contain one worksheet per year, named with
its four-digit year, and the Crossnacreevy weather-station column
layout.

## Explore the documentation

- [Data
  dictionary](https://gaburns.github.io/crossmet/articles/data-dictionary.md)
  — variables, units and interpretation of the imported columns.
- [Function
  reference](https://gaburns.github.io/crossmet/reference/index.md) —
  complete help for every exported function.
- [Graph
  gallery](https://gaburns.github.io/crossmet/articles/visualisations.md)
  — examples of the available weather plots.
- [Source code and issue tracker](https://github.com/GABurns/crossmet).

## About the data

The package is designed around daily station summaries. It does not
replace quality control or metadata from the station operator. Check the
source workbook, instrument metadata and observation coverage before
interpreting long-term trends or comparing variables across periods.
