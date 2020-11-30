context('Test moj_col')

test_that(
  "moj_col returns chosen shade(s) of a colour.",
  {
    expect_equal(
      moj_col("blue", 2),
      "#deebf7")

    expect_equal(
      moj_col("blue", x = c(5, 7), class = 7),
      c("#4292c6", "#084594"))

    expect_equal(
      moj_col("orange", x = 1:3, class = 5),
      c("#feedde", "#fdbe85", "#fd8d3c"))

    expect_equal(
      c(moj_col("red", x = 5:8), moj_col("purple", x = 6:7, class = 8)),
      c("#fb6a4a", "#ef3b2c", "#cb181d", "#a50f15", "#807dba", "#6a51a3"))
  }
)

test_that(
  "moj_col returns an error when passed an NA or NULL,
  a non-valid colour is input to the colour argument,
  the number of data classes chosen was not between 3 and 9,
  or the value(s) of x exceeds the chosen number of classes.",
  {

    expect_error(
      moj_col(NA)
    )

    expect_error(
      moj_col(NULL)
    )

    expect_error(
      moj_col("gold", 8)
    )

    expect_error(
      moj_col("green", x = 10, class = 9)
    )

    expect_error(
      moj_col("red", x = 3, class = 12)
    )

    expect_error(
      c(moj_col("red", x = 5:8, class = 6), moj_col("purple", x = 6:7, class = 8))
    )

  }
)
