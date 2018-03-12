#' Returns name of previous quarter, for within the bulletin.
#' @export

yearago_quarter <- function(){
  stringr::str_c("Q", params$quarter, " ", as.numeric(params$year) - 1, sep = "")
}
