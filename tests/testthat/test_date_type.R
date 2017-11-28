context('Test date_type')

test_that(
  "Returns the correct answer",
  {
    expect_equal(
      date_type("2012-12-31", "%Y"),
      "2012"
    )

    expect_equal(
      date_type("2012-12-31", "%m"),
      "12"
    )

    expect_equal(
      date_type("2012-12-31", "%d"),
      "31"
    )


  }
)
