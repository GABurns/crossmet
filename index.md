---
title: "crossmet"
---

<img src="man/figures/logo.svg" alt="crossmet hexagonal weather logo" width="180" align="right" />

# Weather data from Crossnacreevy, made easier to explore

**crossmet** is an R package for importing, summarising and visualising daily
meteorological observations from the AFBI Crossnacreevy weather station in
Northern Ireland.

Use the package to move from annual Excel worksheets to tidy observations,
year-by-year monthly summaries, long-term monthly climate summaries and
publication-ready plots.

<div class="row">
<div class="col-md-4">
### Import

Read the relevant annual worksheets, validate the workbook structure and
return a tidy long-format data frame.

[Importing guide](articles/importing-data.html)
</div>
<div class="col-md-4">
### Summarise

Compare individual years with \`MonthlySummaryTable()\` or calculate monthly
climate normals with \`ClimateSummaryTable()\`.

[Summary guide](articles/summary-tables.html)
</div>
<div class="col-md-4">
### Visualise

Explore daily time series and a calendar-style grid of each month's daily
weather observations.

[Graph gallery](articles/visualisations.html)
</div>
</div>

## Start here

```r
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

The workbook is expected to contain one worksheet per year, named with its
four-digit year, and the Crossnacreevy weather-station column layout.

## Explore the documentation

- [Data dictionary](articles/data-dictionary.html) — variables, units and
  interpretation of the imported columns.
- [Function reference](reference/index.html) — complete help for every
  exported function.
- [Graph gallery](articles/visualisations.html) — examples of the available
  weather plots.
- [Source code and issue tracker](https://github.com/GABurns/crossmet).

## About the data

The package is designed around daily station summaries. It does not replace
quality control or metadata from the station operator. Check the source
workbook, instrument metadata and observation coverage before interpreting
long-term trends or comparing variables across periods.
