# example dataframe
df <- data.frame("period" = c("2020 Q1", "2020 Q2", "2020 Q3", "2020 Q4"),
                 "receipts" = seq(10, 40, 10))

test_that("change returns the expected values", {
  expect_equal(change(df, "receipts", 40, 2), 20)
  expect_equal(change(df, "receipts", 40, 1, type = "percentage"), "33%")
})

test_that("change raises errors on incorrect inputs", {
  expect_error(change(2, "receipts", 40, 2))
  expect_error(change(df, 23, 40, 2))
  expect_error(change(df, "disposals", 40, 2))
  expect_error(change(df, "receipts", 40, 2.3))
  expect_error(change(df, "receipts", "three", 2))
  expect_error(change(df, "receipts", 40, 2, type = "small"))
})
