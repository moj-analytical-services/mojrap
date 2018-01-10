# incdec
#
#' Returns a character string that quantifies a change.
#
#' @param value value to be quantified
#' @param tense which tense you want the quantifying string to be in. Either
#' "past", "present", "singular" or "plural".
#' @examples
#' incdec("-1", "past")  # returns "decreased by"
#' @export
#'

incdec <- function(value, tense) {

  tryCatch({

    if  (is.null(value) | is.null(tense)) {

      # Check that input is not null, and raise an error if it is

      stop("Input to incdec is NULL", call. = FALSE)

    } else if (is.na(value) | is.na(tense)) {

      # Check that input is not null, and raise and error if it is

      stop("Input to incdec is NA", call. = FALSE)

    } else if (is.character(value) | !is.character(tense)) {

      stop("Input to incdec is a character", call. = FALSE)

    } else {
# BODY --------------------------------------------------------------------


  value <- as.numeric(value) # converts strings into a number

  if (tense == "present") {
    if (value > 0) {
      "increasing by"
      }
    else if (value < 0) {
      "decreasing by"
      }
    else ("ERROR")
  }

  else if (tense == "past") {
    if (value > 0) {
      "increased by"
      }
    else if (value < 0) {
      "decreased by"
      }
    else ("was unchanged")
  }

  else if (tense == "singular") {
    if (value > 0) {
      "increase"
      }
    else if (value < 0) {
      "decrease"
      }
    else ("ERROR")
  }

  else if (tense == "plural") {
    if (value > 0) {
      "increases"
      }
    else if (value < 0) {
      "decreases"
      }
    else ("ERROR")
  }

  else {
    print("please provide a 'tense' as either present, past, singular or plural")
    }

    }

  }, warning = function(war){
    warning(war)

  }, error = function(err){

    err$message <- paste("While selecting description of change", err, sep = " ")
    stop(err)
  })

}
