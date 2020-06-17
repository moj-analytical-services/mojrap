context("Test pub_date funcs")
library("lubridate")

test_that("pub date works", {
  expect_equal(pub_date(pub_day = "Thu", pub_week = 2, first_pub = 2, frequency = "quarterly", bi_start = NA , mago = 0, input_date ="2020-04-29", test=TRUE), as.Date("2020-05-14"))
  expect_error(pub_date())
  expect_error(pub_date(pub_day = "Thu"))
  expect_error(pub_date(pub_day = "Thu", pub_week = 2))
  expect_error(pub_date(pub_day = "Thu", pub_week = 2, first_pub = 2))
  expect_error(pub_date(pub_day = "Thu", pub_week = 2, first_pub = 2, frequency = "quarterly", bi_start = NA , mago = 0, input_date ="29/04/2020", test=TRUE))
  expect_error(pub_date(pub_day = "Thu", pub_week = 2, first_pub = 2, frequency = "quarterly", bi_start = NA , mago = 0, input_date ="29/04/20", test=TRUE))
  })