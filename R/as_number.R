# as_number
#
#' Takes a string and removes all comma delimeters and '\%' signs, before converting to a numerical format.
#
#' @param x A formatted number string
#' @examples
#' as_number("1,000")  #  returns 1000
#' as_number("10%")  #  returns 10
#' @export
#'

as_number <- function (x) {

  # Checks on input

  # Check that only one value is passed to as_number() at a time and raise
  # an error otherwise.

  if (length(x) > 1) {

    stop(
      "Input to as_number is not a single value. ",
      "Most likely you have tried to pass a vector, ",
      "list, or df to as_number()"
    )

    # Check that x is not null, and raise an error if it is

  } else if  (is.null(x)) {

    stop("Input to as_number is NULL")

    # Check that input is not NA, and raise and error if it is

  } else if (is.na(x)) {

    stop("Input to as_number is NA")


  } else if (!is.character(x)){

    stop("Input is not of character type")

  } else {

    # If checks of function pass, then run the main body of the function, and
    # return and output.

    # all lower case
    string <- tolower(x)


    # MAIN BODY ----------------------------------------------------------------

    if (string == "one") {
      out = 1
    }
    else if (string == "two") {
      out = 2
    }

    else if (string == "three") {
      out = 3
    }

    else if (string == "four") {
      out = 4
    }

    else if (string == "five") {
      out = 5
    }

    else if (string == "six") {
      out = 6
    }

    else if (string == "seven") {
      out = 7
    }

    else if (string == "eight") {
      out = 8
    }
    else if (string == "nine") {
      out = 9
    }

    # remove commas or percentages
    else{

      out <- gsub(",", "", string)
      out <- gsub("%", "", out)
      out <-  as.numeric(out)
    }

    return(out)

  }

}
