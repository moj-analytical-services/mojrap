#' Returns period going back a specified number of quarters
#' @param quarters_ago Number of quarters to go back
#' @export
#' 
#' @examples 
#' params$year <- 2016
#' params$quarter <- Q4
#'
#' quarters_ago(1) # Returns "Q3 2016" 
#' quarters_ago(4) # Returns "Q4 2015"

quarters_ago <- function(quarters_ago){
  
  years_ago <- quarters_ago %/% 4
  quarters_ago <- quarters_ago %% 4
  
  year <- params$year - years_ago
  quarter <- params$quarter 
  
  if(quarter <= quarters_ago){
    
    quarter <- quarter + 4 - quarters_ago
    year <- year -1
    
  } else{
    
    quarter <- quarter - quarters_ago
    
  }
  
  paste0("Q", quarter, " ", year)
  
}




# test
# quarters_ago(1) == previous_quater()
# quarters_ago(4) == yearago_quarter()
# quarters_ago(7) == manual 