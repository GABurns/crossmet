# tests/testthat/test-ImportWeather.R


# Test files --------------------------------------------------------------

weather_file <- test_path(
  "fixtures",
  "test_data.xlsx"
)


# Basic import ------------------------------------------------------------

test_that("ImportWeather returns a data frame in long format", {

  result <- ImportWeather(
    file = weather_file,
    start_date = "2024-01-01",
    end_date = "2024-01-05"
  )

  expect_s3_class(result, "data.frame")

  expect_named(
    result,
    c("Date", "DOY", "variable", "value")
  )

  expect_s3_class(result$Date, "Date")
})


# Date filtering ----------------------------------------------------------

test_that("ImportWeather filters dates correctly", {

  result <- ImportWeather(
    file = weather_file,
    start_date = "2024-01-02",
    end_date = "2024-01-04"
  )

  expect_equal(
    min(result$Date),
    as.Date("2024-01-02")
  )

  expect_equal(
    max(result$Date),
    as.Date("2024-01-04")
  )

  expect_equal(
    sort(unique(result$Date)),
    as.Date(c(
      "2024-01-02",
      "2024-01-03",
      "2024-01-04"
    ))
  )
})


# Multiple worksheets ----------------------------------------------------

test_that("ImportWeather combines multiple year sheets", {

  result <- ImportWeather(
    file = weather_file,
    start_date = "2023-12-30",
    end_date = "2024-01-02"
  )

  expected_dates <- as.Date(c(
    "2023-12-30",
    "2023-12-31",
    "2024-01-01",
    "2024-01-02"
  ))

  expect_equal(
    sort(unique(result$Date)),
    expected_dates
  )
})


# Long format -------------------------------------------------------------

test_that("ImportWeather converts weather variables to long format", {

  result <- ImportWeather(
    file = weather_file,
    start_date = "2024-01-01",
    end_date = "2024-01-05"
  )

  expected_variables <- c(
    "Temperature deg C Min",
    "Temperature deg C Max",
    "Air temp Mean",
    "Temp diff deg C",
    "Rainfall mm",
    "Soil 15cm deg C",
    "Soil 45cm deg C",
    "Average Wind speed Km/h",
    "RH (%)",
    "Leaf wetness (U)",
    "Lite totals daily (W/m2)"
  )

  expect_setequal(
    unique(result$variable),
    expected_variables
  )
})


# Number of observations -------------------------------------------------

test_that("ImportWeather returns correct number of long-format rows", {

  result <- ImportWeather(
    file = weather_file,
    start_date = "2024-01-01",
    end_date = "2024-01-05"
  )

  # 5 days x 10 weather variables
  expect_equal(
    nrow(result),
    55
  )
})


# Known values ------------------------------------------------------------

test_that("ImportWeather imports known values correctly", {

  result <- ImportWeather(
    file = weather_file,
    start_date = "2024-01-01",
    end_date = "2024-01-05"
  )

  rainfall <- result |>
    dplyr::filter(
      .data$Date == as.Date("2024-01-01"),
      .data$variable == "Rainfall mm"
    ) |>
    dplyr::pull(.data$value)

  # Change 14.4 to the value stored in your test workbook
  expect_equal(
    rainfall,
    14.10
  )
})


# DOY --------------------------------------------------------------------

test_that("ImportWeather preserves day of year", {

  result <- ImportWeather(
    file = weather_file,
    start_date = "2024-01-01",
    end_date = "2024-01-05"
  )

  doy <- result |>
    dplyr::filter(
      .data$Date == as.Date("2024-01-01")
    ) |>
    dplyr::pull(.data$DOY) |>
    unique()

  expect_equal(
    doy,
    1
  )
})


# Missing file ------------------------------------------------------------

test_that("ImportWeather errors when file does not exist", {

  expect_error(
    ImportWeather(
      file = "not_a_real_file.xlsx",
      start_date = "2024-01-01",
      end_date = "2024-01-05"
    ),
    "Excel file does not exist"
  )
})



