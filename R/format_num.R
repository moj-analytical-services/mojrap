

#' @title  Formating a numeric value to display a comma at the thousands mark for use in a RAP system 
#' 
#' @description This function outputs and formats a numeric value to 
#' appear as a character string with commas separating the thousands mark. The function is a wrapper of the "comma()" function from 
#' the "scales" package 
#'   
#' 
#' @param value The value to be converted
#' 
#' @param big.mark The character to separate the digits. Default here is the comma ","
#' 
#' 
#' @param decimal.mark The character to separate the decimal digits. Default here is the dot "."
#' 
#' @param accuracy The desired accuracy, the number to round up to. 
#' By default this is set to 0.1 and it will round up to the first decimal point.
#' 
#' 
#' @return The value returned is a character string ready to be used by the RAP system in place. 
#' 
#'
#' @author George Papadopoulos
#' 
#' @examples 
#' 
#' format_num(100222)
#' 
#' format_num(200344445.3322, accuracy = 0.01)
#' 
#' @export
#' 
#' 
#' 

# same as format_fcs in the family RAP system. changed the name to avoid confusion here 

format_num = function(value,big.mark = ",",decimal.mark = ".", accuracy = 0.1){
  
  scales::comma(as.numeric(value), big.mark = big.mark, decimal.mark = decimal.mark, accuracy = accuracy)
  
}