test_that("quarter_dates returns the correct results", {
  expect_equal(quarter_dates("2016q1", "start", "%Y %B %d"), "2016 January 01")
  expect_equal(quarter_dates("2021Q1", "end", "%d/%m/%Y"), "31/03/2021")

})

test_that("quarter_dates fails on incorrect arguments", {
  expect_error(quarter_dates(2020-03-31, "start", "%Y %B %d"))
  expect_error(quarter_dates(c("2016q1", "2016q2"), "start", "%Y %B %d"))
  expect_error(quarter_dates(NA, "start", "%Y %B %d"))
  expect_error(quarter_dates(NULL, "start", "%Y %B %d"))
  expect_error(quarter_dates("2016q1", "hat", "%Y %B %d"))
})

