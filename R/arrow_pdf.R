#' Output arrow image for table on PDF bulletin front page
#'
#' @description Function to format the correct path to arrow images for PDF bulletin front page. For this you need to have your .png files stored in a folder called 'images' in the main repo directory. See CCSQ_RAP (https://github.com/moj-analytical-services/CCSQ_RAP) for an example.
#'
#' @param x Number (usually the difference between two figures)
#
#' @examples
#' arrow_pdf(5)
#'
#' @return Path to image of upwards arrow if x is positive, downwards arrow if x is negative or a no change arrow when x is zero.
#'
#' @export

arrow_pdf <- function(x){

  if (is.numeric(x) == FALSE){
    stop("Input must be a number representing a difference between two figures")
  }

  if (x > 0){

    mojrap::arrow_image("up")

  }
  else if (x < 0){

    mojrap::arrow_image("down")

  }
  else {

    mojrap::arrow_image("nochange")

  }

}
