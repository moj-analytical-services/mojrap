#' @title pluralise
#'
#' @description this function takes a given value and outputs whether a word needs to be pluralised based on the value of the input.
#' I.E. if the value is one, the output is not pluralised, if the value is grater than one, the output is pluralised
#' The output can eith pluralise a specific input word, or be used next to an existing word (if the word parameter is left blank)
#'
#' @param value the integer value preceeding your word which needs to be checked for if pluralisation is required
#' @param word the word that you wish to pluralise. Optional, defaults to blank - if blank, the function outputs an 's' (if pluralisation required)
#' to add to the end of an existing word
#'
#' @examples
#' pluralise(4, "percentage point") outputs string "percentage points"
#' pluralise(1, "week") outputs string "week"
#' pluralise(2), outputs string "s"
#' pluralise(1), outputs blank string ""
#' pluralise(-5, "week") outputs string "weeks"
#'
#' Please note - this function simply adds an 's' to pluralise; for more complex pluralisations (e.g. 'ies' rather than 'ys') this function will not provide desired output

pluralise   <- function(value, word = ""){
  
  value <- abs(value)
  
  #CHECKS
  if (value == 0){
    
    stop("the value is zero and thus pluralisation does not make sense. Please enter an integer value greater than zero")
    
  } else if (is.numeric(value) != TRUE){
    
    stop("value argument must be an integer, in order to determine whether pluralisation is required")
    
  } else {  }
  
  if (is.character(word) != TRUE){
    
    stop("the word you enter must be a character string")
    
  } else {}
  
  #BODY
  if (value == 1){
    
    if (word == ""){
      
      out <- ""
      
    } else {
      
      out <- word
      
    }
  } else if (value > 1){
    
    if (word == ""){
      
      out <- "s"
      
    } else {
      
      out <- paste(word, "s", sep = "")
      
    }
  }
  
  out
  
}
