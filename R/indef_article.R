




#' @title  A Function to assign the indefinite article before a word 
#' 
#' @description This function attempts to assign the indefinite article before a given text string. 
#' The function is using the `engish` package at its core and it build so that it can handle numbers and
#' text - see the examples section for more ideas. 
#' 
#' An important note here: The code is not using case_when() to alter between different states since, although conceptually corerct, 
#' it will not work optimaly because of the way case_when() works. The function will calculate all RHS statements first and then evaluate 
#' matches using the LHS ones. Because of that there will be warnings when using the Indefinite() funciton etc. 
#' 
#'   
#' 
#' @param text_var The word before which the article will be placed
#' 
#' @param caps  Whether the end result will be capitalised or not
#' 
#' 
#' 
#' 
#' 
#' 
#' @return A text variable conaining the multistatement ready to be used in the RAP system 
#' 
#' @examples 
#' 
#' 
#' indef_article("word", caps=F)
#' 
#' indef_article("11%", caps=T)
#' 
#' indef_article("11% and a text here", caps=T)
#' 
#' indef_article("11% and a text here", caps=F)
#' 
#' indef_article("11anumber and a solid text here", caps=T)
#' 
#' 
#' 
#' 
#' @export
#' 
#' 
#' 
#' 




# example code using case_when statement - This is Legacy code and kept here so that users can see how to adapt for other potential usage. 
# It will not work optimaly due to the way case_when() works with statements.  

#'if (caps == T){text_out = case_when(
#'   
#'   str_detect(text_var, "^[:digit:]+%.") ~ paste0(Indefinite(as.numeric(str_extract(text_var,"[:digit:]+")), words = F),
#'                                                  str_extract(text_var,"%.+")),
#'   
#'   str_detect(text_var, "^[:digit:]+%") ~ paste0(Indefinite(as.numeric(str_extract(text_var,"[:digit:]+")), words = F), "%"),
#'   
#'   str_detect(text_var, "^[:digit:]+$") ~  Indefinite(as.numeric(text_var), words = F),
#'   
#'   
#'   # TRUE ~  Indefinite(text_var)
#'   # TRUE ~ str_detect(text_var,".*") ~  Indefinite(text_var, words = F)
#'   
#'   TRUE ~ "ERROR please check the code"
#'   
#' )}
#' 





indef_article = function(text_var, caps = T){
  
  require(english)
  require(tidyverse)
  
  #check if the input is a text chat or a number
  
  if(!(is.character(text_var) | is.numeric(text_var))){
    stop("Input must be a character vector or a number (percenage will work as well)")
  }
  

  if(caps == T){  
  if ( str_detect(text_var, "^[:digit:]+%.")){ # to catch a number, a % sign and other text
    text_out = paste0(Indefinite(as.numeric(str_extract(text_var,"[:digit:]+")), words = F),
                      str_extract(text_var,"%.+"))}
    
    else if( str_detect(text_var, "^[:digit:]+ ")){ # to catch a number, space and then text
    text_out = paste0(Indefinite(as.numeric(str_extract(text_var,"[:digit:]+")), words = F),
                      str_extract(text_var," .+")) }
    
    else if( str_detect(text_var, "^[:digit:]+%")){ # to catch a only number and the % sign
    text_out = paste0(Indefinite(as.numeric(str_extract(text_var,"[:digit:]+")), words = F), "%")}
    
    else if( str_detect(text_var, "^[:digit:]+$")){ # to catch a number only
    text_out =  Indefinite(as.numeric(text_var), words = F)}
    
  else { text_out = Indefinite(text_var)}
  
  } 
  
  else if (caps==F){
  
    if ( str_detect(text_var, "^[:digit:]+%.")){ # to catch a number, a % sign and other text
      text_out = paste0(indefinite(as.numeric(str_extract(text_var,"[:digit:]+")), words = F),
                        str_extract(text_var,"%.+"))}
    
    else if( str_detect(text_var, "^[:digit:]+ ")){ # to catch a number, space and then text
      text_out = paste0(indefinite(as.numeric(str_extract(text_var,"[:digit:]+")), words = F),
                        str_extract(text_var," .+")) }
    
    else if( str_detect(text_var, "^[:digit:]+%")){ # to catch a only number and the % sign
      text_out = paste0(indefinite(as.numeric(str_extract(text_var,"[:digit:]+")), words = F), "%")}
    
    else if( str_detect(text_var, "^[:digit:]+$")){ # to catch a number only
      text_out =  indefinite(as.numeric(text_var), words = F)}
    
    else { text_out = indefinite(text_var)}
  
  } else {text_out = "ERROR - please revisit statements"}
  
  
  return(text_out)
  
}





