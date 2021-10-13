test_that("mojquarter returns the correct results", {
  expect_equal(mojquarter('2020-03-31'), "2020q1")
  expect_equal(mojquarter('2020-03-31', 'c'), "2020q1")
  expect_equal(mojquarter('2020-03-31', 'f'), "2019q4")

})

test_that("mojquarter fails on incorrect arguments", {
  expect_error(mojquarter(2020-03-31))
  expect_error(mojquarter(c('2020-03-31', '2020-04-12')))
  expect_error(mojquarter('2020-03-31', 'e'))
  expect_error(mojquarter('2021-02-31'))
  expect_error(mojquarter(NA))
  expect_error(mojquarter(NULL))
})
