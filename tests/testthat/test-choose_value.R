# example dataframe
df <- data.frame("yrqtr" = c("2020 Q1", "2020 Q2", "2020 Q3", "2020 Q4"),
"receipts" = seq(10, 40, 10)
)

test_that("choose_value returns the correct values", {
  expect_equal(choose_value(df, "receipts", "yrqtr", "2020 Q3"), 30)
})

test_that("choose_value raises errors on incorrect inputs", {
  expect_error(choose_value(2, "receipts", "yrqtr", "2020 Q2"))
  expect_error(choose_value(df, receipts, "yrqtr", "2020 Q2"))
  expect_error(choose_value(df, "receipts", yrqtr, "2020 Q2"))
  expect_error(choose_value(df, "receipts", "yrqtr", "2018 Q2"))
  expect_error(choose_value(df, "receipts", "year_qtr", "2020 Q2"))
  expect_error(choose_value(df, "receipts", "yrqtr", NA))
})
