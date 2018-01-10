# connector
#
#' Takes two differences and judges which connecting phrase should be used to compare the differences.
#
#' @param difference1 The first difference in the comparison
#' @param difference2 The second difference in the comparison
#' @examples
#' connector(1, 2) #retunrs ", this is consistent with a" (as both values are positive)
#' @export
#'

connector <- function(difference1, difference2){

  tryCatch({

    # Check that only one value is passed to format_perc() at a time and raise
    # an error otherwise.

    if (length(difference1) > 1 | length(difference2) > 1) {

      stop(
        "Input to connector should be two arguments, each a single value. ",
        call. = FALSE
      )

    } else if  (is.null(difference1) | is.null(difference2)) {

      # Check that input is not null, and raise an error if it is

      stop("Input to connector is NULL", call. = FALSE)

    } else if (is.na(difference1) | is.na(difference2)) {

      # Check that input is not null, and raise and error if it is

      stop("Input to connector is NA", call. = FALSE)

    } else if (!is.numeric(difference1) | !is.numeric(difference1)) {

      stop("Input to connector is not a character", call. = FALSE)

    } else {

      # If checks of function pass, then run the main body of the function, and
      # return and output.


# BODY --------------------------------------------------------------------
  if (difference1 * difference2 < 0) {
    print(", however there has been")
    }

  else  {
    print(", this is consistent with")
    }

    }

  }, warning = function(war){
    warning(war)

  }, error = function(err){

    err$message <- paste("While producing the correct connector phrase", err, sep = " ")
    stop(err)
  })

}

