context('Test arrow_image')

test_that(
  "arrow_image returns correct arrow image when given a sensible input.",
  {
    expect_equal(
      arrow_image("up"),
      "![](images/upfront.png){ width=50% }")

    expect_equal(
      arrow_image("down"),
      "![](images/downfront.png){ width=50% }")

    expect_equal(
      arrow_image("nochange"),
      "![](images/nochangefront.png){ width=50% }")

    expect_equal(
      arrow_image(c("up", "nochange")),
      c("![](images/upfront.png){ width=50% }", "![](images/nochangefront.png){ width=50% }") )
  }
)

test_that(
  "arrow_image returns an error when passed an NA, NULL,
  or any input that is not up, down or nochange in string format.",
  {

    expect_error(
      arrow_image(NA)
    )

    expect_error(
      arrow_image(NULL)
    )

    expect_error(
      arrow_image(up)
    )

    expect_error(
      arrow_image(9)
    )

    expect_error(
      arrow_image("test")
    )

    expect_error(
      arrow_pdf(mtcars)
    )

  }
)
