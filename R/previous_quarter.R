#' Return a previous quarter
#'
#' Given the latest quarter as a string with the year first and then the quarter number, e.g. "2020 Q4", returns a
#' string in the same format representing the previous quarter, or previous quarters going further back if desired.
#'
#' @importFrom lubridate %m-%
#'
#' @param quarter The latest quarter as a string with the year first.
#' @param quarters_ago Number of quarters to go back. Default is 1.
#'
#' @return A character object.
#'
#' @examples
#' previous_quarter("2020 Q1") # returns "2019 Q4"
#' previous_quarter("2020 Q1", 3) # returns "2019 Q2"
#' @export

previous_quarter <- function(quarter, quarters_ago = 1){


  # Checks on input----------------------------------------

  # Check quarter is a character object
  if (!is.character(quarter)){

    stop("quarter must be a character object")
  }

  # Check quarters_ago is an integer
  if(quarters_ago %% 1 != 0){

    stop("quarters_ago must be an integer")
  }

  # Main body----------------------------------------

  # latest quarter
  q <- lubridate::yq(quarter)

  # calculate previous quarter(s)
  pq <- q %m-% months(quarters_ago*3)

  # format it as a string
  pq <- paste0(lubridate::year(pq), " Q", lubridate::quarter(pq))

  return(pq)

}
