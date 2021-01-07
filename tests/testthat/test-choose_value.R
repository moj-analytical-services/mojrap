# example dataframe
df <- data.frame("yrqtr" = c("2015 Q4", "2015 Q4", "2015 Q4", "2016 Q1", "2016 Q1", "2016 Q1"),
                  "type" = c("receipts", "disposals", "outstanding", "receipts", "disposals", "outstanding"),
                  "total" = 1:6)

df2 <- data.frame("period" = c("2019 Q4", "2020 Q1", "2020 Q2", "2020 Q3", "2020 Q4"),
                  "receipts" = c(100, seq(10, 40, 10)))



test_that("choose_value returns the expected values", {
  expect_equal(choose_value(df, "yrqtr", "2015 Q4", "total", "type", "outstanding"), 3)
  expect_equal(choose_value(df2, "period", "2020 Q1", "receipts"), 10)
})

test_that("choose_value raises errors on incorrect inputs", {
  expect_error(choose_value(2, "yrqtr", "2015 Q4", "total", "type", "outstanding"))
  expect_error(choose_value(df, 2, "2015 Q4", 3, "type", "outstanding"))
  expect_error(choose_value(df, "yrqtr", "2010 Q4", "total", "type", "outstanding"))
  expect_error(choose_value(df, "year_quarter", "2015 Q4", "total", "type", "outstanding"))
  expect_error(choose_value(df, "yrqtr", "2015 Q4", "sum", "type", "outstanding"))
  expect_error(choose_value(df, "yrqtr", "2015 Q4", "sum", "type", "outstanding"))
  expect_error(choose_value(df, "yrqtr", "2015 Q4", "total", 3, "outstanding"))
  expect_error(choose_value(df, "yrqtr", "2015 Q4", "total", "hype", "outstanding"))
  expect_error(choose_value(df, "yrqtr", "2015 Q4", "total", "type", "foo"))
})
