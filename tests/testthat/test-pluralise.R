context("Test pluralise function")

test_that("pluralise() works", {
  expect_error(pluralise())
  expect_error(pluralise("week"))
  expect_error(pluralise(0))
  expect_equal(pluralise(5), "s")
  expect_equal(pluralise(-10, "year"), "years")

})
