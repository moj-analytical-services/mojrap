context("Test get_quarter get_annual get_biennial")
library("lubridate")

test_that("get quarter works",{
  expect_equal(get_quarter(dmy("01/07/19"),3),dmy("01/09/19"))
  expect_equal(get_quarter(dmy("15/02/34"),1),dmy("01/04/34"))
  expect_equal(get_quarter(dmy("22/12/78"),2),dmy("01/02/79"))
})

test_that("get annual works",{
  expect_equal(get_annual(dmy("01/07/19"),5),dmy("01/05/19"))
  expect_equal(get_annual(dmy("15/03/34"),3),dmy("01/03/34"))
  expect_equal(get_annual(dmy("22/12/78"),10),dmy("01/10/78"))
  expect_equal(get_annual(dmy("30/10/09"),2), dmy("01/02/09"))
  
})

test_that("get biennial works",{
  expect_equal(get_biennial(dmy("01/07/19"),2,"odd"),dmy("01/02/19"))
  expect_equal(get_biennial(dmy("20/02/76"),12,"even"),dmy("01/12/76"))
  expect_equal(get_biennial(dmy("12/11/27"),5,"even"),dmy("01/5/28")) 
  expect_error(get_biennial(dmy("12/11/27"),5,"neither"))
  expect_error(get_biennial(dmy("12/11/27"),5,NA))
})