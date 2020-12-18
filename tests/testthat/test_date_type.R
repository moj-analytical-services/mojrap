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

test_that("date_type raises an error on incorrect arguments being provided",
  {
    expect_error(date_type(c("2012-12-31", "2020-12-13"), "%Y"))
    expect_error(date_type(2012-12-31, "%Y"))
    expect_error(date_type(2012-12-31, "%Y"))
    expect_error(date_type("2012-12-31"))
    expect_error(date_type(NA, "%Y"))
    expect_error(date_type(NULL, "%Y"))

})
