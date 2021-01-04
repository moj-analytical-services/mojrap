#' Quarter start/end dates
#'
#' Returns either the start or the end date of a given quarter.
#'
#' @param date A quarter with the year first and then the quarter number, e.g. "2020q1".
#' @param start_end Either "start" or "end" to select the start or end date of the quarter.
#' @param type Specifies the format of the date, using standard R date types.
#' @seealso \code{\link{date_type}}
#'
#' @return A character object.
#'
#' @examples
#' quarter_dates("2016q1", "start", "%Y %B %d") # returns "2016 January 01"
#'
#' @export
#'

quarter_dates <- function(date, start_end, type) {

  # Check that only one value is passed at a time and raise an error otherwise.

  if (length(date) > 1) {

    stop("Input date was a vector, but a single value is required")

  # Check that input is not null, and raise an error if it is

  } else if  (is.null(date)) {

    stop("Input date is NULL")

  # Check that input is not NA, and raise and error if it is

  } else if (is.na(date)) {

    stop("Input date is NA")

  # Check that the input is of character type, raise an error if not

  } else if (!is.character(date)) {

    stop("Input date is not of character type", call. = FALSE)

  # Check that start_end is either "start" or "end"

  } else if(!start_end %in% c("start", "end")) {

    stop("start_end must be either 'start' or 'end'")

  } else {

  # If checks of function pass, then run the main body of the function, and
  # return and output.


  # BODY --------------------------------------------------------------------


  date <- lubridate::yq(date)

  if (start_end == "start") {

    start <- as.character(lubridate::floor_date(date, unit = "quarter"))
    return(date_type(start, type))

  }

  else if (start_end == "end") {

    end <- as.character(lubridate::rollback(lubridate::ceiling_date(date, unit = "quarter")))
    return(date_type(end, type))
    }

  }

}
