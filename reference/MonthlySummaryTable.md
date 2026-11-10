# Monthly Summary Table

Creates monthly weather summaries separately for each year. Rainfall and
solar radiation are summed; daily maximum and minimum temperatures are
represented by their monthly maximum and minimum; all other variables
are represented by their monthly mean.

## Usage

``` r
MonthlySummaryTable(data, ...)
```

## Arguments

- data:

  A data frame containing Date, variable, and value columns.

- ...:

  Additional arguments (currently unused).

## Value

A tibble with one row per year and variable, and one column per month. A
month-variable combination with no non-missing observations is NA.

## Author

Gareth Burns
