# example dataframe
df <- data.frame("yrqtr" = c("2020 Q1", "2020 Q2", "2020 Q3", "2020 Q4"),
"receipts" = seq(10, 40, 10)
)

test_that("change returns the expected values", {
  expect_equal(change(df, "receipts", c("yrqtr", "2020 Q2", "2020 Q4")), 20)
  expect_equal(change(df, "receipts", c("yrqtr", "2020 Q2", "2020 Q4"), type = "percentage"), "100%")
})

test_that("change raises errors on incorrect inputs", {
  expect_error(change(2, "receipts", c("yrqtr", "2020 Q2", "2020 Q4")))
  expect_error(change(df, receipts, c("yrqtr", "2020 Q2", "2020 Q4")))
  expect_error(change(df, "receipts", c(yrqtr, "2020 Q2", "2020 Q4")))
  expect_error(change(df, "receipts", c("year_qtr", "2020 Q2", "2020 Q4")))
  expect_error(change(df, "receipts", c("yrqtr", "2019 Q2", "2020 Q4")))
  expect_error(change(df, "receipts", c("yrqtr", "2020 Q2", "2022 Q4")))
  expect_error(change(df, "receipts", c("yrqtr", "2020 Q2")))
  expect_error(change(df, "receipts", c("yrqtr", "2020 Q2", "2020 Q4"), type = "fractional"))
})
