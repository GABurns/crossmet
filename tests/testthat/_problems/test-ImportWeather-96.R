# Extracted from test-ImportWeather.R:96

# setup ------------------------------------------------------------------------
library(testthat)
test_env <- simulate_test_env(package = "crossmet", path = "..")
attach(test_env, warn.conflicts = FALSE)

# prequel ----------------------------------------------------------------------
weather_file <- test_path(
  "fixtures",
  "test_data.xlsx"
)

# test -------------------------------------------------------------------------
result <- ImportWeather(
    file = weather_file,
    start_date = "2024-01-01",
    end_date = "2024-01-05"
  )
