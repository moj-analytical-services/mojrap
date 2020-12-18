#' Convert dates to publication quarters
#'
#' Convert dates in "\%Y\%m\%d" format, i.e. with date formats in that order but
#' with arbitrary or no separators, to either calendar or financial quarters (i.e. where the financial
#' year starts on the 4th month of the year).
#'
#' @param date A date in the form "\%Y\%m\%d".
#' @param type Either "c" or "f", to specify a calender quarter or a financial quarter.
#
#' @examples
#' mojquarter('2020-03-31', "f") # returns "2019q4"
#'
#' @return A character object.
#'
#' @export

mojquarter <- function(date, type = "c") {

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

    stop("Input date is not a character", call. = FALSE)

    # Check that type is either "c" or "f"

  } else if(!type %in% c("c", "f")) {

    stop("type must be either 'c' or 'f'")

  } else {

  # If checks of function pass, then run the main body of the function, and
  # return and output.


# BODY --------------------------------------------------------------------

  if(type == "c") {

    date <- lubridate::ymd(date)
    year <- lubridate::year(date)
    return(paste0(year, "q", lubridate::quarter(date, fiscal_start = 1)))

  }

  else if(type == "f") {

    date <- lubridate::ymd(date) - months(3)
    year <- lubridate::year(date)
    return(paste0(year, "q", lubridate::quarter(date)))

    }

  }
}
