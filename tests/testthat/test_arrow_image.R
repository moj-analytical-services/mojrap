context("test_arrow_image.R")

library(asdrap)

testthat::test_that("error messages work", {
  testthat::expect_warning(arrow_image("neither_up_nor_down"))
  })
