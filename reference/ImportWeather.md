# Import weather data from Excel

Imports weather data from an Excel workbook where individual worksheets
contain data for separate years. Only worksheets required to cover the
requested date range are imported. The resulting data are combined,
filtered to the requested dates, and converted to long format.

The Excel workbook is expected to contain the following columns:
\`date\`, \`DOY\`, \`Temperature deg C\`, \`Air temp\`, \`Temp diff\`,
\`Rainfall\`, \`Soil 15cm\`, \`Soil 45cm\`, \`Average Wind\`, \`RH\`,
\`Leaf\`, and \`Lite totals\`.

Worksheet names are expected to contain the four-digit year, for example
\`"2023"\`, \`"2024"\`, and \`"2025"\`.

## Usage

``` r
ImportWeather(file, start_date = "2013-01-01", end_date = Sys.Date())
```

## Arguments

- file:

  Character string. Path to the Excel workbook containing the weather
  data.

- start_date:

  Start date of the period to import. Either a \`Date\` object or a
  character string that can be converted to a date using \`as.Date()\`,
  e.g. \`"2023-01-01"\`.

- end_date:

  End date of the period to import. Either a \`Date\` object or a
  character string that can be converted to a date using \`as.Date()\`,
  e.g. \`"2025-12-31"\`.

## Value

A tibble in long format with four columns:

- date:

  Observation date.

- DOY:

  Day of year.

- variable:

  Weather variable measured.

- value:

  Observed value.

## Details

Only worksheets corresponding to years between \`start_date\` and
\`end_date\` are read. For example, a request from \`"2023-06-01"\` to
\`"2025-04-30"\` will attempt to read the 2023, 2024 and 2025
worksheets.

After the worksheets have been combined, observations outside the
requested date range are removed.

## Author

Gareth Burns

## Examples

``` r
if (FALSE) { # \dontrun{
weather <- import_weather(
  file = "weather.xlsx",
  start_date = "2022-01-01",
  end_date = "2025-12-31"
)

weather
} # }
```
