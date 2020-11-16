context('Test arrow_utf')

test_that(
  "arrow_utf returns correct arrow image depending on number that is input.",
  {
    expect_equal(
      arrow_utf(765),
      intToUtf8(11016))

    expect_equal(
      arrow_utf(-47),
      intToUtf8(11018))

    expect_equal(
      arrow_utf(0),
      intToUtf8(11020))
  }
)

test_that(
  "arrow_utf returns an error when passed an NA, NULL,
  or any other non-integer.",
  {

    expect_error(
      arrow_utf(NA)
    )

    expect_error(
      arrow_utf(NULL)
    )

    expect_error(
      arrow_utf("up")
    )

    expect_error(
      arrow_utf("9")
    )

    expect_error(
      arrow_utf(mtcars)
    )

  }
)
