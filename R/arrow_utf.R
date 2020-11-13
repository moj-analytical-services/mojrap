#' Output UTF Arrows
#'
#' @description Function to output  Unicode Transformation Format (UTF) arrows depending on the number provided.
#'
#' @param x Number (usually the difference between two figures)
#
#' @examples
#' arrow_utf(5)
#'
#' @return UTF arrow depending on whether number is positive, negative or equal to zero
#'
#' @export

arrow_utf <- function(x){

  if (is.numeric(x) == FALSE){
    stop("Input must be a number representing a difference between two figures")
  }

  if (x > 0){

    intToUtf8(11016)

  }
  else if (x < 0){

    intToUtf8(11018)

  }
  else {

    intToUtf8(11020)

  }

}
