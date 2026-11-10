% Generated documentation for MonthlySummaryTable
\name{MonthlySummaryTable}
\alias{MonthlySummaryTable}
\title{Monthly Summary Table}
\usage{
MonthlySummaryTable(data, ...)
}
\arguments{
\item{data}{A data frame containing Date, variable, and value columns.}
\item{...}{Additional arguments (currently unused).}
}
\value{
A tibble with one row per year and variable, and one column per month.
A month-variable combination with no non-missing observations is NA.
}
\description{
Creates monthly weather summaries separately for each year. Rainfall and solar
radiation are summed; daily maximum and minimum temperatures are represented by
their monthly maximum and minimum; all other variables are represented by their
monthly mean.
}
\author{Gareth Burns}
