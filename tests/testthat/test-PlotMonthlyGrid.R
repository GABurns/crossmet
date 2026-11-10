test_that("PlotMonthlyGrid adds a layer for relative humidity", {
  weather <- data.frame(
    Date = as.Date(c("2024-01-01", "2024-01-02")),
    variable = "RH (%)",
    value = c(70, 75)
  )

  plot <- PlotMonthlyGrid(weather, variable = "RH (%)")

  expect_s3_class(plot, "ggplot")
  expect_true(length(plot$layers) >= 1)
  expect_match(plot$labels$title, "RH")
})

test_that("PlotMonthlyGrid accepts a custom title", {
  weather <- data.frame(
    Date = as.Date("2024-01-01"),
    variable = "Rainfall mm",
    value = 2
  )

  plot <- PlotMonthlyGrid(weather, variable = "Rainfall mm",
                          title = "My rainfall plot")

  expect_identical(plot$labels$title, "My rainfall plot")
})

test_that("PlotMonthlyGrid validates its input data", {
  expect_error(
    PlotMonthlyGrid(data.frame(Date = as.Date("2024-01-01"))),
    "missing required column"
  )

  weather <- data.frame(
    Date = as.Date("2024-01-01"),
    variable = "Rainfall mm",
    value = 2
  )
  expect_error(
    PlotMonthlyGrid(weather, variable = "Air temp Mean"),
    "No observations found"
  )
})

test_that("PlotMonthlyGrid plots a temperature range", {
  weather <- data.frame(
    Date = as.Date(c("2024-01-01", "2024-01-01")),
    variable = c("Temperature deg C Min", "Temperature deg C Max"),
    value = c(3, 8)
  )

  plot <- PlotMonthlyGrid(weather, variable = "temperature_range")

  expect_s3_class(plot, "ggplot")
  expect_equal(length(plot$layers), 3)
})
