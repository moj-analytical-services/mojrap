# example dataframe
df <- data.frame("yrqtr" = c("2020 Q1", "2020 Q2", "2020 Q3", "2020 Q4", "2021 Q1"),
                 "receipts" = seq(0, 40, 10)
)

test_that("change returns the expected values", {
  expect_equal(change(df, "receipts", "yrqtr", "2020 Q2", "2020 Q4"), 20)
  expect_equal(change(df, "receipts", "yrqtr", "2020 Q3", "2021 Q1", type = "percentage"), "100%")
})

test_that("change raises errors on incorrect inputs", {
  expect_error(change(2, "receipts", "yrqtr", "2020 Q2", "2020 Q4"))
  expect_error(change(df, receipts, "yrqtr", "2020 Q2", "2020 Q4"))
  expect_error(change(df, "receipts", yrqtr, "2020 Q2", "2020 Q4"))
  expect_error(change(df, "receipts", "year_qtr", "2020 Q2", "2020 Q4"))
  expect_error(change(df, "receipts", "yrqtr", "2020Q2", "2020 Q4"))
  expect_error(change(df, "receipts", "yrqtr", "2019 Q2", "2020 Q4"))
  expect_error(change(df, "receipts", "yrqtr", "2020 Q2", "2022 Q4"))
  expect_error(change(df, "receipts", "yrqtr", "2020 Q2"))
  expect_error(change(df, "receipts", "yrqtr", "2020 Q1", "2021 Q1", type = "percentage"))
  expect_error(change(df, "receipts", "yrqtr", "2020 Q2", "2020 Q4", type = "fractional"))
  expect_error(change(df, "receipts", "yrqtr", NA, "2020 Q4"))
  expect_error(change(df, "receipts", "yrqtr", "2020 Q2", NA))
})
