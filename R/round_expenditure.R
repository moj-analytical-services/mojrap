#' @title Round expenditure
#'
#' @description Formats expenditure depending on how many digits it has. Rounds numbers to 1 decimal place.
#'
#' @param value An amount of expenditure in £
#
#' @examples
# round_expenditure(456098) gives you £456.1k
# round_expenditure(9357256) gives you £9.4m
#'
#' @return A character object.
#'
#' @export

round_expenditure <- function(value) {

  tryCatch({

    # Check that only one value can be input, and raise an error if it is

    if (length(value) > 1) {

      stop(
        "Input to format_expenditure is not a single value. ",
        "Most likely you have tried to pass a vector, ",
        "list, or df to format_expenditure()",
        call. = FALSE
      )

    } else if  (is.null(value)) {

      # Check that value is not null, and raise an error if it is

      stop("Input to format_expenditure is NULL", call. = FALSE)

    } else if (is.na(value)) {

      # Check that value is not NA, and raise and error if it is

      stop("Input to format_expenditure is NA", call. = FALSE)

    } else if (is.numeric(value) == FALSE) {
      # Check that the value is a number, and raise an error if it isn't
      stop("Input to format_expenditure is not a number", call. = FALSE)

    }  else if (abs(value) < 1000000) {

      # If checks of function pass, then run the main body of the function, and
      # return and output.

      value <- mojrap::format_expenditure(value, format = 'k')
      return(value)

    } else if (abs(value) >= 1000000) {

      value <- mojrap::format_expenditure(value)
      return(value)


    }
  }
  , warning = function(war){
    warning(war)

  }
  , error = function(err){

    err$message <- paste("While formatting expenditure", err, sep = " ")
    stop(err)
  })
}
