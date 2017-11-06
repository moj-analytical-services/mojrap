context('Test connector')

test_that(
  "Picks the correct output phrase",
  {
    expect_equal(
      connector(1, 2),
      ", this is consistent with a"

    )

    expect_equal(
      connector(-2, -2),
      ", this is consistent with a"

    )

    expect_equal(
      connector(-2, 1),
      ", however there has been a"

    )

  }
)
