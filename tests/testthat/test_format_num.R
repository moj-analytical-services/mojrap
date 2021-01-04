context('Test format_num')

test_that(
  "format_num returns correct values when given a sensible input.",
  {
    expect_equal(
      format_num("1000"),
      "1,000")

    expect_equal(
      format_num("1"),
      "one"
    )

    expect_equal(
      format_num("7", less_than_10_as_words = FALSE),
      "7"
    )
  }
)

test_that("format_num raises errors on incorrect inputs",{
  expect_error(format_num(c("1000", "2000")))
  expect_error(format_num(NA))
  expect_error(format_num(NULL))
  expect_error(format_num("7", less_than_10_as_words = "foo"))
})
