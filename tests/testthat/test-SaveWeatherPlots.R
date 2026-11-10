test_that("SaveWeatherPlots rejects unknown plot names", {
  weather <- data.frame(
    Date = as.Date("2024-01-01"),
    DOY = 1,
    variable = "Rainfall mm",
    value = 1
  )

  expect_error(
    SaveWeatherPlots(weather, plots = "not-a-plot", monthly_grids = FALSE),
    "Unknown plot"
  )
})

test_that("SaveWeatherPlots returns an empty path vector when no plots are requested", {
  weather <- data.frame(
    Date = as.Date("2024-01-01"),
    DOY = 1,
    variable = "Rainfall mm",
    value = 1
  )

  result <- SaveWeatherPlots(
    weather, plots = character(), monthly_grids = FALSE,
    path = tempfile("crossmet-plots-")
  )

  expect_identical(result, character())
})
