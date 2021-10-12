# example dataframe
df <- data.frame("yrqtr" = c("2020 Q1", "2020 Q2", "2020 Q3", "2020 Q4", "2021 Q1"),
                 "receipts" = c(10,4,5,10, NA)
)

test_that("change_desc returns the expected values", {
  expect_equal(change_desc(df, "receipts", "yrqtr", "2020 Q2", "2020 Q3"), "increased")
  expect_equal(change_desc(df, "receipts", "yrqtr", "2020 Q1", "2020 Q2"), "decreased")
  expect_equal(change_desc(df, "receipts", "yrqtr", "2020 Q1", "2020 Q4"), "did not change")
})

test_that("change_desc raises errors on incorrect inputs", {
  expect_error(change_desc(2, "receipts", "yrqtr", "2020 Q2", "2020 Q3"))
  expect_error(change_desc("df", "receipts", "yrqtr", "2020 Q2", "2020 Q3"))
  expect_error(change_desc(df, receipts, "yrqtr", "2020 Q2", "2020 Q3"))
  expect_error(change_desc(df, "receipts", yrqtr, "2020 Q2", "2020 Q3"))
  expect_error(change_desc(df, "receipts", "yrqtr", "2018 Q2", "2020 Q3"))
  expect_error(change_desc(df, "receipts", "year_qtr", "2020 Q2", "2020 Q3"))
  expect_error(change_desc(df, "receipts", "yrqtr", "2020 Q2", "2021 Q4"))
  expect_error(change_desc(df, "receipts", "yrqtr", "2020 Q2", "2021 Q1"))
  expect_error(change_desc(df, "receipts", "yrqtr", "2020 Q2"))
  expect_error(change_desc(df, "receipts", "yrqtr", NA, "2020 Q4"))
  expect_error(change_desc(df, "receipts", "yrqtr", "2020 Q2", NA))
})
