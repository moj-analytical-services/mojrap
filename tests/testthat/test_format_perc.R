context('Test format_perc')

test_that(
  "format_perc returns correct values when given a sensible input.",
  {
    expect_equal(
      format_perc(0.1),
      "10%"
    )

    expect_equal(
      format_perc(0.01),
      "1%"
    )

    expect_equal(
      format_perc(10),
      "1000%"
    )
  }
)

test_that(
  "format_perc returns an error when passed an NA, NULL,
  or object with length greater than 1.",
  {

    expect_error(
      format_perc(NA)
    )

    expect_error(
      format_perc(NULL)
    )

    expect_error(
      format_perc(1:3)
    )

    expect_error(
      format_perc(list(1:3))
    )

    expect_error(
      format_perc(mtcars)
    )

  }
)

test_that(
  "format_perc returns an NA when passed an NA, and error_on_NA = FALSE",
  {
    expect_equal(is.na(format_perc(NA, error_on_NA = FALSE)), TRUE)

  }
)
