#' Return a previous quarter
#'
#' Given the latest quarter as a string with the year first and then the quarter number, e.g. "2020 Q4", returns a
#' string in the same format representing the previous quarter, or previous quarters going further back if desired.
#'
#' @importFrom lubridate %m-%
#'
#' @param quarter The latest quarter as a string, starting with the year, a 'q' or 'Q', then the quarter number (1,2,3 or 4).
#' @param quarters_ago Number of quarters to go back. Default is 1.
#'
#' @return A character object.
#'
#' @examples
#' previous_quarter("2020 Q1") # returns "2019 Q4"
#' previous_quarter("2020 Q1", 3) # returns "2019 Q2"
#' @export

previous_quarter <- function(quarter, quarters_ago = 1){

  # Checks on input arguments----------------------------------------

  # Check that only one value is passed at a time and raise an error otherwise.
  if (length(quarter) > 1) {

    stop("Input quarter was a vector, but a single value is required")

    # Check that input is not null, and raise an error if it is

  }

  else if (length(quarters_ago) > 1) {

    stop("Input number was a vector, but a single value is required")

    # Check that input is not null, and raise an error if it is

  }


  else if  (is.null(quarter)) {

    stop("Input quarter is NULL")

    # Check that input is not NA, and raise and error if it is

  }

  else if (is.na(quarter)) {

    stop("Input quarter is NA")

    # Check quarter is a character object

  }

  else if (!is.character(quarter)){

    stop("The latest quarter must be provided as a string")
  }

  else if (!is.numeric(quarters_ago)){

    stop("quarters_ago needs to be provided as a numeric")
  }

  # Check quarters_ago is an integer
  if(quarters_ago %% 1 != 0){

    stop("quarters_ago must be an integer")
  }

  # Check quarters_ago is positive
  if(quarters_ago <= 0){

    stop("quarters_ago needs to be a positive number")
  }

  # MAIN BODY-----------------------------------------------

  # parse string for the latest quarter
  q <- lubridate::yq(quarter)

  # calculate previous quarter(s)
  pq <- q %m-% months(quarters_ago*3)

  # format it as a string
  pq <- paste0(lubridate::year(pq), " Q", lubridate::quarter(pq))

  pq

}
