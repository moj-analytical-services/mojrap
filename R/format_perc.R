#' Format percentages
#'
#' Convert fractions to percentages.
#'
#' @param fraction A fraction
#' @param error_on_NA A logical
#'
#' @return A character object.
#'
#' @examples
#'
#' format_perc(0.1) # returns "10%"
#' format_perc(10) # returns "1000%"
#' format_perc(NA, error_on_NA = FALSE) # returns NA
#'
#' @export

format_perc <- function(fraction, error_on_NA = TRUE) {

  tryCatch({

    # Check that only one value is passed to format_perc() at a time and raise
    # an error otherwise.

    if (length(fraction) > 1) {

      stop(
        "Input to fraction_perc is not a single value. ",
        "Most likely you have tried to pass a vector, ",
        "list, or df to format_perc()",
        call. = FALSE
        )

    } else if  (is.null(fraction)) {

      # Check that fraction is not null, and raise an error if it is

      stop("Input to fraction_perc is NULL", call. = FALSE)

    }

    else if (is.na(fraction)) {

      # raise an error if the fraction is NA and error_on_NA is TRUE
      if (error_on_NA == TRUE){

        stop("Input to fraction_perc is NA", call. = FALSE)

      # return an NA if the fraction is NA and error_on_NA is FALSE
      } else {

        return(NA)

        }

    }
    else {

      # If checks of function pass, then run the main body of the function, and
      # return and output.

      fraction <- paste(abs(round(as.numeric(fraction) * 100, 0)), "%", sep = "")
      return(fraction)

    }
  }
  , warning = function(war){
    warning(war)

  }
  , error = function(err){

    err$message <- paste("While formatting percentage", err, sep = " ")
    stop(err)
  })
}
