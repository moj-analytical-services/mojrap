test_that("previous_quarter returns the correct values", {
  expect_equal(previous_quarter("2020 Q1"), "2019 Q4")
  expect_equal(previous_quarter("2020 Q1", 3), "2019 Q2")
})

test_that("previous_quarter raises errors on incorrect input", {
  expect_error(previous_quarter(3))
  expect_error(previous_quarter("2020 Q1", 3.2))
})
