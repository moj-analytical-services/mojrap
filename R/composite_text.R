

#' @title  Helper function to assist in the creating multiple sentences
#' 
#' @description This function is used as a helper mechanism to allow for simpler implementation of the 
#' multistatement function. The main result of the `composite_text` function is to create a text component/variable 
#' for use in the multistatement parent funciton. It will align the `categories` `change` and `perc` so that each will in order 
#'   
#'   
#' 
#' @param comp_data A data frame comprised of 3 columns,`categories`, `change` and `perc`. These refer to the following:
#' 
#' \itemize{
#' 
#' \item `categories`{This column details the names of the categories to include in the multistatement}
#' 
#' \item `change` {The corresponding change for each of the categories}
#' 
#' \item `perc` {The percentage associated with the hange in the previous column }
#' 
#' }
#' 
#' 
#'  
#' 
#' 
#' @return A text variable that is to be used to contruct the multistatement structure. 
#' This is stylised for use in later stages of the process
#' 
#' @examples 
#' 
#' df = tribble(
#'          ~categories, ~change, ~perc,
#'          "a",   -3, "10%",
#'          "b",   2, "12",
#'          "c",   1, "5%",
#'            )
#' 
#' composite_text(df)
#' 
#' @export
#' 
#' 
#' 


composite_text = function(comp_data){
  
  # browser()
  
  if (nrow(comp_data)==0){
    return(text_1 = "")
  }
  
  else if (length(comp_data$categories) >= 2 ){
    
    
    text_1 = paste0(comp_data$categories[1]," (",comp_data$perc[1],")")
    
    for (k in 2:length(comp_data$categories)){
      
      if(k==length(comp_data$categories)) {
        text_1 = paste0(text_1, " and ", comp_data$categories[k]," (",comp_data$perc[k],")")  
      }else{
        text_1 = paste0(text_1, ", ", comp_data$categories[k]," (",comp_data$perc[k],")")  
        
      }
      
    }
    
  } else if (length(comp_data$categories)==1){ text_1 = paste0(comp_data$categories[1]," (",comp_data$perc[1],")")}
  
  else {text_1 = "ERROR - PLEASE CHECK THE CODE"}
  
  
  
  
  return(text_1)
  
  
  
}

