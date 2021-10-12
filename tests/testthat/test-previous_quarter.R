test_that("previous_quarter returns the correct values", {
  expect_equal(previous_quarter("2020 Q1"), "2019 Q4")
  expect_equal(previous_quarter("2020 Q1", 3), "2019 Q2")
  expect_equal(previous_quarter("2020 Q4", 5), "2019 Q3")
})

test_that("previous_quarter raises errors on incorrect input", {
  expect_error(previous_quarter(3))
  expect_error(previous_quarter("2020 Q1", 3.2))
  expect_error(previous_quarter("2020 Q1", "3"))
  expect_error(previous_quarter(c("2020 Q1", "2020 Q3"), 3))
  expect_error(previous_quarter("2021q2", c(2,3)))
  expect_error(previous_quarter("2020 Q1", -2))
})
