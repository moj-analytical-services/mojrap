context('Test as_number')

test_that(
  "as_number handles commas and %.",
  {
    expect_equal(
      as_number(",,%,,1,%%3,37"),
      1337
    )
  }
)

test_that(
  "as_number handles CAPS",
  {
    expect_equal(
      as_number("One"),
      1
    )
  }
)

test_that(
  "as_number handles one to nine",
  {
    expect_equal(
      c(as_number("nine"),
        as_number("five")),
      c(9, 5)
    )
  }
)

test_that("as_number raises errors on incorrect inputs",{
  expect_error(as_number(1000))
  expect_error(as_number(NA))
  expect_error(as_number(NULL))
  expect_error(as_number(c("1000", "2000")))
})
