# Importing Crossnacreevy weather data

\`\`\`{r, include = FALSE} knitr::opts_chunk\$set(collapse = TRUE,
comment = “#\>”) \`\`\`

## Workbook layout

\`ImportWeather()\` reads an Excel workbook containing one worksheet per
calendar year. Worksheets must be named with their four-digit year, such
as \`2022\`, \`2023\` and \`2024\`.

The Crossnacreevy workbook layout uses two header rows followed by daily
observations. The importer expects the date and day-of-year fields and
the weather columns for minimum/maximum temperature, mean air
temperature, temperature difference, rainfall, soil temperature at 15 cm
and 45 cm, average wind speed, relative humidity, leaf wetness and daily
light totals.

Keep the source workbook unchanged and retain a copy of the station’s
measurement metadata. The data dictionary lists the variable labels and
the units exposed by this package.

## Import a date range

Pass the workbook path and inclusive start and end dates:

\`\`\`{r, eval = FALSE} library(crossmet)

weather \<- ImportWeather( file = “data/crossnacreevy.xlsx”, start_date
= “2020-01-01”, end_date = “2024-12-31” )

head(weather) dplyr::glimpse(weather) \`\`\`

Only the annual worksheets needed for the requested date range are read.
Observations outside the requested dates are removed after the sheets
are combined.

## Returned data

The result is a long-format data frame with four columns:

- \`Date\`: observation date.
- \`DOY\`: day of year from the workbook.
- \`variable\`: weather measurement name.
- \`value\`: numeric daily observation.

Each date normally appears once per weather variable. This tidy
structure is suitable for \`dplyr\` filtering and grouping, the
summary-table functions and the plotting functions.

## Validation and missing data

The importer checks that the workbook exists, that the requested dates
are valid, and that the selected year worksheets contain the expected
columns. A requested year without a worksheet produces a warning; an
import cannot proceed if none of the requested year sheets are
available.

Missing measurements are retained as \`NA\`. Dates absent from the
workbook are not automatically generated, and the importer does not
interpolate, impute, calibrate or apply station quality-control flags.
Check observation coverage and the source workbook before calculating
totals or trends.

## Example workflow

\`\`\`{r, eval = FALSE} \# Inspect one variable rain \<-
dplyr::filter(weather, variable == “Rainfall mm”)

## Create monthly summaries by year

monthly \<- MonthlySummaryTable(weather)

## Create long-term monthly climate summaries

climate \<- ClimateSummaryTable(weather)

## Plot daily rainfall

RainfallPlot(weather) \`\`\`

See the [data
dictionary](https://gaburns.github.io/crossmet/articles/data-dictionary.md)
for field definitions and units, and the [function
reference](https://gaburns.github.io/crossmet/reference/ImportWeather.md)
for all arguments and return details.
