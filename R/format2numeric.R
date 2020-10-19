

#' @title  Converting a character value to numeric for use in a RAP system
#' 
#' @description This is the complement function to `format_num()` and it will transform a corresponding character value back to numeric 
#'   
#' 
#' @param value The value to be converted
#' 
#' @param separator The character to separate the digits. Default here is the comma ","
#' 
#' 
#'  
#' @return The value returned is a numeric ready to be used by the RAP system in place. 
#' 
#'
#' 
#' 
#' @examples 
#' 
#' format2numeric(format_num(100222))
#' 
#' format2numeric(format_num(200344445.3322, accuracy = 0.01))
#' 
#' @export
#' 
#' 
#' 



format2numeric = function(char_value, separator = ","){
  
  options(digits = 10)
  num_value = str_replace_all(char_value, ",", replacement = "") %>% as.numeric()
  
  return(num_value)
  
}