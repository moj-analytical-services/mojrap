context('Test incdec')

test_that(
  "incdec returns correct values when given a sensible input.",
  {
    expect_equal(
      incdec("-1", "past"),
      "decreased by")

    expect_equal(
      incdec("2", "present"),
      "increasing by")

    expect_equal(
      incdec("-1", "plural"),
      "decreases")

    expect_equal(
      incdec("1", "singular"),
      "increase")
  }
)
