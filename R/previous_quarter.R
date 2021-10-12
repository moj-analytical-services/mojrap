#' Return a previous quarter
#'
#' Given the latest quarter as a string in the format "2020 Q4", returns a
#' string in the same format representing the previous quarter, or previous quarters going further back if desired.
#'
#' @importFrom lubridate %m-%
#'
#' @param quarter The latest quarter as a string, starting with the year, a 'q' or 'Q', then the quarter number (1,2,3 or 4), e.g. "2020 Q2".
#' @param quarters_ago Number of quarters to go back. Default is 1. If negative, the number of quarters to go forward.
#'
#' @return A character object.
#'
#' @examples
#' previous_quarter("2020 Q1") # returns "2019 Q4"
#' previous_quarter("2020 Q1", 3) # returns "2019 Q2"
#' @export

previous_quarter <- function(quarter, quarters_ago = 1){


  # Checks on input arguments----------------------------------------

  ### quarter checks

  # Check that only one value is passed at a time to quarter, and raise an error otherwise.
  if (length(quarter) > 1) {

    stop("Input quarter was a vector, but a single value is required")
  }

  # Check quarter is a character object
  if (!is.character(quarter)){

    stop("The latest quarter must be provided as a string")
  }

  ### quarters_ago checks

  # Check that only one value is passed at a time to quarters_ago, and raise an error otherwise.
  if (length(quarters_ago) > 1) {

    stop("Input to quarters_ago was a vector, but a single value is required")
  }

  # Check quarters_ago is numeric, if not raise an error
  if(!is.numeric(quarters_ago)){

    stop("quarters_ago must be an integer")
  }

  # Check quarters_ago is an integer
  if(quarters_ago %% 1 != 0){

    stop("quarters_ago must be an integer")
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
