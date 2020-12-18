context('Test connector')

test_that(
  "connector picks the correct output phrase",
  {
    expect_equal(
      connector(1, 2),
      ", this is consistent with"

    )

    expect_equal(
      connector(-2, -2),
      ", this is consistent with"

    )

    expect_equal(
      connector(-2, 1),
      ", however there has been"

    )

  }
)

test_that("connector fails on incorrect arguments",{
  expect_error(connector(c(2,3), 7))
  expect_error(connector(7))
  expect_error(connector(7, "a"))
  expect_error(connector(NA, 4))
  expect_error(connector(4, NULL))
}
)
