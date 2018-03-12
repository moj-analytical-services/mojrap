#' Returns name of latest quarter, for within the bulletin.
#' @export

latest_quarter <- function(){
  paste0("Q", params$quarter, " ", params$year)
}
