# example dataframe
df <-  df <- data.frame("period" = c("2019 Q4", "2020 Q1", "2020 Q2", "2020 Q3", "2020 Q4"),
                        "receipts" = c(100, seq(10, 40, 10)))


test_that("change_desc returns the expected values", {
  expect_equal(change_desc(df, "receipts", 40, 2), "increased")
  expect_equal(change_desc(df, "receipts", 40, 4), "decreased")
})

test_that("change_desc raises errors on incorrect inputs", {
  expect_error(change_desc(2, "receipts", 40, 2))
  expect_error(change_desc(df, 23, 40, 2))
  expect_error(change_desc(df, "disposals", 40, 2))
  expect_error(change_desc(df, "receipts", 40, 2.3))
  expect_error(change_desc(df, "receipts", "three", 2))
})
