




#' @title  A Function to assign the indefinite article before a word 
#' 
#' @description This function attempts to ssign the indefinite article before a given text string. 
#' Currently this will work with words but not numbers or anythig that cannot be used by regex 
#' which is the core ext recognition engine used.  
#' 
#' #'   
#' 
#' @param text_var The word before which the article will be placed
#' 
#' @param caps  Whether the nd result will be capitalised or not
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
#' 
#' article_indef("word", caps=F)
#' 
#' article_indef("A", caps=T)
#' 
#' 
#' @export
#' 
#' 
#' 








indef_article = function(text_var, caps = F){
  
  
  if (caps == T){
    
    if (str_detect(text_var, "^[AaEeIiOoUu]")){
      
      text_out = paste("An", text_var)
      
    }else{
      text_out = paste("A", text_var)
    }
  }else if (caps == F){
    
    if (str_detect(text_var, "^[AaEeIiOoUu]")){
      
      text_out = paste("an", text_var)
      
    }else{
      text_out = paste("a", text_var)
    }
    
    
  }
  
  
  return(text_out)
  
}

