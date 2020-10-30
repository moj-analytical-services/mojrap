#' @title  Chooses arrow image for table on bulletin front page
#'
#' @description Function to format the correct path to arrow inages for bulletin front page. For this you need to have your .png files stored in a folder called 'images' in the main repo directory. See CCSQ_RAP for an example
#'
#' @param x Direction of arrow (up, down, nochange)
#
#' @examples
#' arrow_image("up")
#'
#' @export

arrow_image <- function(x){

  if (tolower(x) %in% c("up", "down", "nochange")){

    stringr::str_c("![](images/", tolower(x), "front.png){ width=50% }")

  } else {

    warning("Incorrect input, please enter 'up', 'down' or 'nochange'.")

  }

}
