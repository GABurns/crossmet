test_that("ClimateSummaryTable averages yearly monthly summaries", {
  weather <- data.frame(
    Date = as.Date(c("2023-01-01", "2023-01-02", "2024-01-01")),
    variable = "Air temp Mean",
    value = c(2, 4, 10)
  )

  result <- ClimateSummaryTable(weather)

  expect_equal(nrow(result), 1)
  expect_equal(result$Jan, 6.5)
})

test_that("ClimateSummaryTable averages annual rainfall totals", {
  weather <- data.frame(
    Date = as.Date(c("2023-01-01", "2023-01-02", "2024-01-01")),
    variable = "Rainfall mm",
    value = c(1, 2, 5)
  )

  result <- ClimateSummaryTable(weather)

  expect_equal(result$Jan, 4)
})
