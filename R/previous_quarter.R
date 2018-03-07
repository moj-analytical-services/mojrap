#' Returns name of previous quarter, for within the bulletin.
#' @export

previous_quarter <- function(){
  stringr::str_c(
    "Q",
    ifelse(as.numeric(params$quarter) == 1, 4,
           as.numeric(params$quarter) - 1),
    " ",
    ifelse(params$quarter == 1, as.numeric(params$year) - 1, params$year),
    sep = ""
  )
}
