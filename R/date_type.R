#' Format dates
#'
#' Transform dates in "\%Y\%m\%d" format, i.e. with date formats in that order but
#' with arbitrary or no separators, to a specified date format.
#'
#' @param date A date in "\%Y\%m\%d" format.
#' @param type Specifies the format that the date should be returned in,
#'   using standard R date types.
#'
#' @return A character object.
#'
#' @examples
#' date_type("2012-12-31", "%Y")  # returns 2012
#'
#' @export
#'

date_type <- function(date, type) {

  tryCatch({

    # Check that only one value is passed to date_type at a time and raise
    # an error otherwise.

    if (length(date) > 1) {

      stop("Input to date_type was a vector, but a single value is required", call. = FALSE)

    # Check that input is not null, and raise an error if it is

    } else if  (is.null(date)) {

      stop("Input to date_type is NULL", call. = FALSE)

    # Check that input is not NA, and raise and error if it is

    } else if (is.na(date)) {

      stop("Input to date_type is NA", call. = FALSE)

    # Check that the input is of character type, raise an error if not

    } else if (!is.character(date)) {

      stop("Input to date_type is not a character", call. = FALSE)

    } else {

      # If checks of function pass, then run the main body of the function, and
      # return and output.


# BODY --------------------------------------------------------------------



  return(format(lubridate::ymd(date), format = type))

    }

  }, warning = function(war){
    warning(war)

  }, error = function(err){

    err$message <- paste("While extracting the preferred date format", err, sep = " ")
    stop(err)
  })

}
