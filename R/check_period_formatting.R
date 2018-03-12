#' Checks period is always in "Q4 2016" format
#' @param period Time period. More specifically, quarter and year
#' 
#' @examples 
#' check_period_formatting("2016 Q3") # returns 0 i.e. does not pass the test
#' check_period_formattion("Q3 2016") # returns 1 i.e. passes test

check_period_formatting <- function(period){
  
  output <- 1
  
  if (stringr::str_detect(period, "Q[1,2,3,4] \\d\\d\\d\\d") == FALSE){
  
    output <- 0
    
  } else if (stringr::str_length(period) != 7){
    
    output <- 0
    
  }
  
  return(output)
  
}