





#' @title  Function to construct statements from multiple categories 
#' 
#' @description This function automates to a large extent the creation of statements having multiple categories 
#' each with a certain percentage change to accompany it.
#' 
#' #'   
#' 
#' @param comp_data A data frame comprised of 3 columns,`categories`, `change` and `perc`. These refer to the following:
#' 
#' \itemize{
#' 
#' \item `category_names`{This column details the names of the categories to include in the multistatement}
#' 
#' \item `category_changes` {The corresponding change for each of the categories}
#' 
#' \item `category_perc` {The percentage associated with the hange in the previous column }
#' 
#' \item `order_of_placement` {Control the order in which the categories are presented. Set to either
#' "increase" to depict the categoreis in an increasing order or "decrease" otherwise.}
#' 
#' }
#' 
#' '  
#' 
#' 
#' @return A text variable conaining the multistaement ready to be used in the RAP system
#' 
#' @examples 
#' 
#' df = tribble(
#'          ~categories, ~change, ~perc,
#'          "cata",   -3, "10%",
#'          "castb",   2, "12%",
#'          "catc",   1, "5%",
#'            )
#' 
#' 
#' 
#' multi_statement(category_names = df$categories, 
#' category_changes = df$change, category_perc = df$perc, order_of_placement = "increase")
#' 
#' 
#' @author George Papadopoulos
#' 
#' 
#' @export
#' 
#' 
#' 








multi_statement = function(category_names, category_changes, category_perc ,order_of_placement){
  
  data_in = data.frame(categories = category_names, changes = category_changes, perc = category_perc) %>%
    arrange(changes)
  
  # browser()
  
  data_negative = filter(data_in,changes < 0)
  
  data_positive = filter(data_in, changes > 0)
  
  
  if ((order_of_placement == "increase") & (dim(data_positive)[1] != 0)){
    
    text_1 = composite_text(data_positive)
    
    text_2 = composite_text(data_negative)
    
    if(nrow(data_negative)==0){text_out = paste0("This was due to increases in ", text_1,".")
    
    } else{
      text_out = paste0("This was due to increases in ", text_1, " However, there was a deecrease in ", text_2,".")
    }
    
    
    
  } else if (order_of_placement == "decrease" & (dim(data_negative)[1] != 0)){
    
    text_1 = composite_text(data_positive)
    
    text_2 = composite_text(data_negative)
    
    
    if(nrow(data_positive)==0){text_out = paste0("This was due to increases in ", text_2,".")
    
    } else{
      text_out = paste0("This was due to decreases in ", text_2," However, there was an increase in ", text_1,".")
    }
    
    
    
    # text_out = paste0("This was due to decreases in ", text_2," However, there were increases in , ", text_1)
    
  } else{ text_out = "ERROR - PLEASE CHECK THE CODE"}
  
  
  # The assumption here is that there is no case wher eyou have an increase/decrease in the all encompassing parent category without 
  # a corresponding increase/decrease in the individual child categories. So in other words, if there is an increase in the parent category
  # this would be because you had at least one increase in the child categories. 
  
  return(text_out)
  
  
}



