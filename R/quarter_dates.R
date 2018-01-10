# quarter_dates
#
#' Gives the start/end dates of a quarter
#' @param date A quarter eg. 2016q1
#' @param start_end Select either the start date of the quarter or the end date of the quarter
#' @param type format of the date
#' @seealso \code{\link{date_type}}
#' @examples quarter_dates("2016q1", "start", "%Y %B %d") returns 2016 January 1
#' @export
#'


#
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

quarter_dates <- function(date, start_end, type) {

  date <- tolower(date)
  year <- substr(date, 1, 4)

  if (substr(date, 5, 6) == "q1") {
    start <- paste(year, "-", "01", "-", "01", sep = "")
    end <- paste(year, "-", "03", "-", "31", sep = "")
    }
  else if (substr(date, 5, 6) == "q2") {
    start <- paste(year, "-", "04", "-", "01", sep = "")
    end <- paste(year, "-", "06", "-", "30", sep = "")
    }
  else if (substr(date, 5, 6) == "q3") {
    start <- paste(year, "-", "07", "-", "01", sep = "")
    end <- paste(year, "-", "09", "-", "30", sep = "")
    }
  else if (substr(date, 5, 6) == "q4") {
    start <- paste(year, "-", "10", "-", "01", sep = "")
    end <- paste(year, "-", "12", "-", "31", sep = "")
    }
  else
    print("Please enter a quarter dates in the form eg. '2016q1'")


  if (start_end == "start") {
    mojrap::date_type(start, type)
    }
  else if (start_end == "end") {
    mojrap::date_type(end, type)
    }
  else
    print("Please select either 'start' or 'end' date")

}
