context('Test arrow_pdf')

test_that(
  "arrow_pdf returns correct arrow image depending on number that is input.",
  {
    expect_equal(
      arrow_pdf(765),
      "![](images/upfront.png){ width=50% }")

    expect_equal(
      arrow_pdf(-47),
      "![](images/downfront.png){ width=50% }")

    expect_equal(
      arrow_pdf(0),
      "![](images/nochangefront.png){ width=50% }")
  }
)

test_that(
  "arrow_pdf returns an error when passed an NA, NULL,
  or any other non-integer.",
  {

    expect_error(
      arrow_pdf(NA)
    )

    expect_error(
      arrow_pdf(NULL)
    )

    expect_error(
      arrow_pdf("up")
    )

    expect_error(
      arrow_pdf("9")
    )

    expect_error(
      arrow_pdf(mtcars)
    )

  }
)
