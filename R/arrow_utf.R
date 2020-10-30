#' Output UTF Arrows
#'
#' @description Function to output UTF arrows depending on number.
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
