#' @title  Formating the percentage value for use in a RAP system 
#' 
#' @description This function outputs and formats the percentage change between a pair of values. 
#'   
#' 
#' @param previous_value Having quarterly changes in mind (between two consecutive years), this is the previous quarter value. 
#' 
#' @param current_value Having quarterly changes in mind (between two consecutive years), this is the current quarter value.
#' 
#' @param round_digits The number of digits to round up the result, default value is set to zero (0)
#' 
#' @param times100 Whether the result should be presented as a decimal number or a percentage, default flag set to TRUE, 
#' meaning that the result will be in the percentage format
#' 
#' 
#' @return The value returned is a character string ready to be used by the RAP system in place. 
#' 
#' @author George Papadopoulos
#' 
#' 
#' @examples 
#' 
#' format_perc(100,120)
#' 
#' format_perc(100,99.5)
#' 
#' @export
#' 
#' 
#' 


# same as "format_perc_v2()" in the FSC rap system. Used a simpler name here to avoid confusion. 

format_perc = function(previous_value, current_value, round_digits = 0, times100 = T){
  
  
  # to catch cases where we have division by zero or an NA present anywhere
  
  if((is.na(current_value) | is.na(previous_value)) | (current_value == 0 | previous_value == 0) ){
    
    if(times100==T)
      perc = paste("by less than 1%")
    else{perc = 0}
    
  }else{
    
    # if all is well continue here
    if(times100 == T){
      perc =  round((current_value/previous_value -1)*100, digits = round_digits)
      
      if(abs(perc)>1){
        perc = paste0(abs(perc),"%")
      }else{
        perc = paste("by less than 1%")
      }
      
    }else{
      perc = round((current_value/previous_value -1), digits = round_digits) 
      # in this case there is a numeric output for use in otehr stages
    }
    
    
  }
  
  # to return text output 
  
  
  
  return(perc)
  
  
  
  
}
