context('Test col_series')

test_that(
  "col_series returns chosen number of shades of a colour.",
  {
    expect_equal(
      col_series("blue", 5),
      c("#eff3ff", "#bdd7e7", "#6baed6", "#3182bd", "#08519c"))

    expect_equal(
      col_series("purple", 8),
      c( "#fcfbfd", "#efedf5", "#dadaeb", "#bcbddc", "#9e9ac8", "#807dba", "#6a51a3", "#4a1486"))
  }
)

test_that(
  "col_series returns an error when passed an NA or NULL,
  a non-valid colour is input to the colour argument,
  or the number of data classes chosen was not between 3 and 9.",
  {

    expect_error(
      col_series(NA)
    )

    expect_error(
      col_series(NULL)
    )

    expect_error(
      col_series("gold", 8)
    )

    expect_error(
      col_series("green", 15)
    )

    expect_error(
      col_series("green", -5)
    )

  }
)
