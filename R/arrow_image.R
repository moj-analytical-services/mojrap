#' @title  Chooses arrow image for table on bulletin front page
#'
#' @description Function to format the correct path to arrow images for bulletin front page.
#'
#' @param x Direction of arrow (up, down, nochange)
#' @param image_path The path to the directory containing the arrow images. Default is a folder called 'images' in the repo root directory.
#'
#' @return Path to image of upwards arrow if x is "up", downwards arrow if x is "down" or a no change arrow if x is "nochange".
#
#' @examples
#' arrow_image("up")
#'
#' @export

arrow_image <- function(x, image_path="images"){
  if(is.null(x) == TRUE){
    stop("Incorrect input, please enter 'up', 'down' or 'nochange' in string format.")
  }

  else{
  ifelse(tolower(x) %in% c("up", "down", "nochange"),
         stringr::str_c("![](", image_path, "/", tolower(x), "front.png){ width=50% }"),
         stop("Incorrect input, please enter 'up', 'down' or 'nochange' in string format."))
  }
}
