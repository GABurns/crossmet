% Generated documentation for ClimateSummaryTable
\name{ClimateSummaryTable}
\alias{ClimateSummaryTable}
\title{Monthly Climate Summary Table}
\usage{
ClimateSummaryTable(data)
}
\arguments{
\item{data}{A data frame containing Date, variable, and value columns.}
}
\value{
A tibble with one row per variable and one column per calendar month.
Years with no non-missing observations for a month-variable combination are
excluded from that climatological average; if all years are missing, the result
is NA.
}
\description{
Calculates long-term monthly climatological summaries across years. Daily
observations are first summarised within each calendar year: rainfall and solar
radiation are summed, daily maximum and minimum temperatures are represented by
monthly maxima and minima, and other variables are represented by monthly means.
The resulting yearly monthly values are then averaged across years.
}
\author{Gareth Burns}
