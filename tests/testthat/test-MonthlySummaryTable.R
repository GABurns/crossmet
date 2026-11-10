test_that("MonthlySummaryTable keeps calendar years separate", {
  weather <- data.frame(
    Date = as.Date(c("2023-01-01", "2023-01-02", "2024-01-01")),
    variable = "Air temp Mean",
    value = c(2, 4, 10)
  )

  result <- MonthlySummaryTable(weather)

  expect_equal(result$year, c(2023, 2024))
  expect_equal(result$Jan, c(3, 10))
})

test_that("MonthlySummaryTable uses monthly totals and preserves all-missing values", {
  weather <- data.frame(
    Date = as.Date(c("2023-02-01", "2023-02-02", "2023-02-03")),
    variable = "Rainfall mm",
    value = c(1, 2, NA_real_)
  )

  result <- MonthlySummaryTable(weather)

  expect_equal(result$Feb, 3)
})
