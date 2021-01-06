context('Test round_expenditure')

test_that(
  "round_expenditure returns expenditure in correct format.",
  {
    expect_equal(
      round_expenditure(36573436),
      "£36.6m")

    expect_equal(
      round_expenditure(3562),
      "£3.6k")

    expect_equal(
      round_expenditure(65),
      "£0.1k")
  }
)

test_that(
  "round_expenditure returns an error when passed an NA, NULL or non-integer.",
  {

    expect_error(
      round_expenditure(NA)
    )

    expect_error(
      round_expenditure(NULL)
    )

    expect_error(
      round_expenditure("number")
    )

    expect_error(
      format_expenditure("1200000")
    )

  }
)
