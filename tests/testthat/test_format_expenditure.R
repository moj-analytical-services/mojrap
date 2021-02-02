context('Test format_expenditure')

test_that(
  "format_expenditure returns expenditure in correct format.",
  {
    expect_equal(
      format_expenditure(36573436),
      "£36.6m")
    expect_equal(
      format_expenditure(3562744, currency = "$"),
      "$3.6m")
    expect_equal(
      format_expenditure(3562744, format = "k"),
      "£3562.7k")
    expect_equal(
      format_expenditure(4654262.65, currency = "£", dp = 3),
      "£4.654m")
  }
)

test_that(
  "format_expenditure returns an error when passed incorrect arguments",
  {

    expect_error(
      format_expenditure(NA)
    )
    expect_error(
      format_expenditure(NULL)
    )
    expect_error(
      format_expenditure("number")
    )
    expect_error(
      format_expenditure(number)
    )
    expect_error(
      format_expenditure(4654262.65, dp = "3")
    )
    expect_error(
      format_expenditure(4654262.65, dp = 3.2)
    )
    expect_error(
      format_expenditure(c(4654262.65, 3562744))
    )
    expect_error(
      format_expenditure(4654262.65, format = k)
    )
    expect_error(
      format_expenditure(4654262.65, format = "s")
    )
    expect_error(
      format_expenditure(4654262.65, currency = USD)
    )




  }
)
