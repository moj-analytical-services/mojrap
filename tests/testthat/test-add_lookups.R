test_that("add_lookups returns errors on incorrect arguments", {
  expect_error(add_lookups(mydata, c("lookup1.csv", "lookup2.csv"), "regionname"))
  expect_error(add_lookups(mydata, "lookup1.csv", c("regionname", "areaname")))
  expect_error(add_lookups(mydata,"alpha-test-data/lookup-file.csv",2))
})
