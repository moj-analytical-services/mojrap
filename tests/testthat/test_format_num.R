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
  }
)
