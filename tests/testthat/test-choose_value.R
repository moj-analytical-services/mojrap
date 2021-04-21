# example dataframe
df1 <- data.frame("yrqtr" = c("2015 Q4", "2015 Q4", "2015 Q4", "2016 Q1", "2016 Q1", "2016 Q1"),
                  "type" = c("receipts", "disposals", "outstanding", "receipts", "disposals", "outstanding"),
                  "total" = 1:6
)

df2 <- data.frame("yrqtr" = c("2020 Q1", "2020 Q2", "2020 Q3", "2020 Q4"),
                  "receipts" = seq(10, 40, 10)
)



test_that("choose_value returns the correct values", {
  expect_equal(choose_value(df1, "total", c("yrqtr", "2015 Q4"), c("type", "receipts")), 1)
  expect_equal(choose_value(df2, "receipts", c("yrqtr", "2020 Q1")), 10)
})

test_that("choose_value raises errors on incorrect inputs", {
  expect_error(choose_value(2, "total", c("yrqtr", "2015 Q4"), c("type", "receipts")))
  expect_error(choose_value(df1, total, c("yrqtr", "2015 Q4"), c("type", "receipts")))
  expect_error(choose_value(df1, 2, c("yrqtr", "2015 Q4"), c("type", "receipts")))
  expect_error(choose_value(df1, "total", c("year_quarter", "2015 Q4"), c("type", "receipts")))
  expect_error(choose_value(df1, "total", c("yrqtr", "2012 Q4"), c("type", "receipts")))
  expect_error(choose_value(df1, "total", c("yrqtr", "2015 Q4"), c(type, "receipts")))
  expect_error(choose_value(df1, "total", c("yrqtr", "2015 Q4"), c(2, "receipts")))
  expect_error(choose_value(df1, "total", c("yrqtr", "2015 Q4"), c("type", "total")))
  expect_error(choose_value(df2, "receipts", c("yrqtr")))
  expect_error(choose_value(df1, "total", c("yrqtr", "2015 Q4"), c("type")))
  expect_warning(choose_value(df1, "total", c("yrqtr", "2015 Q4")))

})
