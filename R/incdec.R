# incdec
#
#' Returns a character string that quantifies a change, randomly choosing from a
#' set of words to describe the change.
#
#' @param value value to be quantified
#' @param tense which tense you want the quantifying string to be in. Either
#' "past", "present", "singular" or "plural".
#' @param seed a random seed to be used within the function only. Any existing
#' seed in your R environment will be restored after the function is called.
#' Default is NULL, which returns different results each time the function is
#' called.
#' @examples
#' incdec(-1, "past", seed = 14)  # always returns "has fallen by"
#' incdec(-1, "past") # returns one of "has fallen by", "is down by",
#' "decreased by"
#' @export
#'

incdec <- function(value, tense, seed = NULL) {

  # Check input arguments

    if  (is.null(value) | is.null(tense)) {

      # Check that input is not null, and raise an error if it is

      stop("Input to incdec is NULL", call. = FALSE)

    } else if (is.na(value) | is.na(tense)) {

      # Check that input is not null, and raise and error if it is

      stop("Input to incdec is NA", call. = FALSE)

    } else if (is.character(value) | !is.character(tense)) {

      stop("Input to incdec is a character", call. = FALSE)

    } else if (!tense %in% c("past", "present", "singular", "plural")) {

      stop("Please provide a 'tense' as either present, past, singular or plural")
    }

  else {

# MAIN BODY --------------------------------------------------------------------

  value <- as.numeric(value) # converts strings into a number

  # Save any existing random seed before we reset it within this function, then reapply the original seed on exit
  old <- .Random.seed
  on.exit( { .Random.seed <<- old } )

  # Set new seed just for this function
  set.seed(seed)

  if (tense == "present") {
    if (value > 0) {
      sample((c("up by", "rising by", "increasing by")), 1)
      }
    else if (value < 0) {
      sample((c("falling by", "down by", "decreasing by")), 1)
      }
    else ("remaining unchanged")
  }

  else if (tense == "past") {
    if (value > 0) {
      sample((c("was up by", "has risen by", "increased by")), 1)
      }
    else if (value < 0) {
      sample((c("has fallen by", "is down by", "decreased by")), 1)
      }
    else ("was unchanged")
  }

  else if (tense == "singular") {
    if (value > 0) {
      sample((c("increase", "rise")), 1)
      }
    else if (value < 0) {
      sample((c("fall", "drop", "decrease", "decline")), 1)
      }
    else ("no change")
  }

  else if (tense == "plural") {
    if (value > 0) {
      "increases"
      }
    else if (value < 0) {
      "decreases"
      }
    else ("no changes")
  }

 }

}
