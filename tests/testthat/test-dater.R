library("lubridate")

test_that("set_interval works", {
  expect_equal(set_interval("quarterly") , 3)
  expect_equal(set_interval("annually") , 12)
  expect_equal(set_interval("monthly") , 1)
  expect_equal(set_interval("biennially") , 24)
  expect_error(set_interval("none of the above"))
})

test_that("backdate_date works", {
  expect_equal(backdate_date(dmy("01/01/1900"),1) , dmy("01/12/1899"))
  expect_equal(backdate_date(dmy("25/06/2150"),16) , dmy("25/02/2149"))
  expect_warning(backdate_date(dmy("30/02/2019"),2), "1 failed to parse.")
})

test_that("find_day works", {
  expect_equal(find_day(dmy("15/06/2010"),3,"Thu"), dmy("17/06/2010"))
  expect_equal(find_day(dmy("02/09/1922"),4,"Sat"), dmy("23/09/1922"))
  expect_equal(find_day(dmy("28/01/1991"),2,"Mon"), dmy("14/01/1991"))
  expect_equal(find_day(dmy("19/12/2019"),5,"Wed"), dmy("25/12/2019"))
})

test_that("get_quarter works", {
  expect_equal(get_quarter(dmy("01/01/2021"), 1), dmy("01/01/2021"))
})

test_that("get_annual works", {
  expect_equal(get_annual(dmy("01/01/2021"), 4), dmy("01/04/2021"))
})

test_that("get_biennial works", {
  expect_equal(get_biennial(dmy("01/04/2021"), 4, "even"), dmy("01/04/2022"))
  expect_equal(get_biennial(dmy("01/04/2021"), 4, "odd"), dmy("01/04/2021"))
})

test_that("pub date works", {
  expect_equal(pub_date(pub_day = "Thu", pub_week = 2, first_pub = 2, frequency = "quarterly", bi_start = NA , mago = 0, input_date ="2020-04-29", test=TRUE), as.Date("2020-05-14"))})

test_that("pub_date raises errors on incorrect inputs",{
  expect_error(pub_date())
  expect_error(pub_date(pub_day = "Thu"))
  expect_error(pub_date(pub_day = "Thu", pub_week = 2))
  expect_error(pub_date(pub_day = "Thu", pub_week = 2, first_pub = 2))
  expect_error(pub_date(pub_day = "Thu", pub_week = 2, first_pub = 2, frequency = "quarterly", bi_start = NA , mago = 0, input_date ="29/04/2020", test=TRUE))
  expect_error(pub_date(pub_day = "Thu", pub_week = 2, first_pub = 2, frequency = "quarterly", bi_start = NA , mago = 0, input_date ="29/04/20", test=TRUE))
})
