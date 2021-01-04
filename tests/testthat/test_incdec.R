context('Test incdec')

test_that(
  "incdec returns correct values when given a sensible input.",
  {
    expect_equal(
      incdec(-1, "past"),
      "decreased by")

    expect_equal(
      incdec(2, "present"),
      "increasing by")

    expect_equal(
      incdec(-1, "plural"),
      "decreases")

    expect_equal(
      incdec(1, "singular"),
      "increase")
  }
)

test_that("incdec raises errors on incorrect arguments",{
  expect_error(incdec(NA))
  expect_error(incdec(NULL))
  expect_error(incdec(NA, NA))
  expect_error(incdec(NULL, NULL))
  expect_error(incdec(-1))
  expect_error(incdec(-1, "foo"))
  expect_error(incdec(0, "present"))
  expect_error(incdec(0, "singular"))
  expect_error(incdec(0, "plural"))
})
