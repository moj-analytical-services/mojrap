#' Convert dates to publication quarters
#'
#' Convert dates as a string in "YYYY-MM-DD" format, with arbitrary separators, to either calendar or
#' financial quarters. N.B. a financial year in the UK starts in April.
#'
#' @param date A date as a string in the format "YYYY-MM-DD". Only last two digits for the year is also valid.
#' @param type Either "c" or "f", to specify a calender quarter or a financial quarter. By default, the function outputs a calendar quarter.
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

    stop("Input date is not in character format", call. = FALSE)

    # Check that input date is valid

  } else if (is.na(lubridate::ymd(date))){

    stop("Input date must be valid and entered as a character in the form of YYYY-MM-DD")


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

    date <- lubridate::ceiling_date(lubridate::ymd(date), "months") - months(3) - lubridate::days(1)
    year <- lubridate::year(date)
    return(paste0(year, "q", lubridate::quarter(date)))

    }

  }
}
