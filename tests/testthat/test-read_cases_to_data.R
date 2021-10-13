test_that("read_cases_to_data returns errors on incorrect arguments", {
  expect_error(read_cases_to_data(c("SAS", "CSV"),"alpha-test-data/popdata.sas7bdat",c("sex","age","region")))
  expect_error(read_cases_to_data("txt","alpha-test-data/popdata.sas7bdat",c("sex","age","region")))
  expect_error(read_cases_to_data("SAS",c("path1", "path2"),c("sex","age","region")))
  expect_error(read_cases_to_data("SAS",5,c("sex","age","region")))
  expect_error(read_cases_to_data("SAS","alpha-test-data/popdata.sas7bdat",c(2,3,4)))
})
