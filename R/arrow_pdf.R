#' Output arrow image for table on PDF bulletin front page
#'
#' @description Function to format the correct path to arrow images for PDF bulletin front page.
#'
#' @param x Number (usually the difference between two figures)
#' @param path The path to the directory containing the arrow images. Default is a folder called 'images' in the main repo directory. See CCSQ_RAP (https://github.com/moj-analytical-services/CCSQ_RAP) for an example
#
#' @examples
#' arrow_pdf(5)
#'
#' @return Path to image of upwards arrow if x is positive, downwards arrow if x is negative or a no change arrow when x is zero.
#'
#' @export

arrow_pdf <- function(x, path="images"){

  if (is.numeric(x) == FALSE){
    stop("Input must be a number representing a difference between two figures")
  }

  if (x > 0){

    arrow_image("up", image_path = path)

  }
  else if (x < 0){

    arrow_image("down", image_path = path)

  }
  else {

    arrow_image("nochange", image_path = path)

  }

}
