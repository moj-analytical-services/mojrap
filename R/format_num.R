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
# format_num
#
#' Formats numbers with a comma delimiter and values of less than 10 are represented as words
#' @param number A number
#' @examples
#' format_num("1000") # returns "1,000"
#' format_num("1") # returns 'one'
#' @export

format_num <- function(number) {

  tryCatch({

    # Check that only one value is passed to format_perc() at a time and raise
    # an error otherwise.

    if (length(number) > 1) {

      stop(
        "Input to format_num is not a single value. ",
        "Most likely you have tried to pass a vector, ",
        "list, or df to format_num()",
        call. = FALSE
      )

    } else if  (is.null(number)) {

      # Check that number is not null, and raise an error if it is

      stop("Input to number_perc is NULL", call. = FALSE)

    } else if (is.na(number)) {

      # Check that number is not null, and raise and error if it is

      stop("Input to number_perc is NA", call. = FALSE)

    } else {

      # If checks of function pass, then run the main body of the function, and
      # return and numberput.

      number <- formatC(abs(as.numeric(number)),
                     big.mark = ",", digits = 0, format = "d")

      if (mojrap::as_number(number) == 1) {
        number <- "one"
      }
      else  if (mojrap::as_number(number) == 2) {
        number <- "two"
      }
      else  if (mojrap::as_number(number) == 3) {
        number <- "three"
      }
      else  if (mojrap::as_number(number) == 4) {
        number <- "four"
      }
      else  if (mojrap::as_number(number) == 5) {
        number <- "five"
      }
      else  if (mojrap::as_number(number) == 6) {
        number <- "six"
      }
      else  if (mojrap::as_number(number) == 7) {
        number <- "seven"
      }
      else  if (mojrap::as_number(number) == 8) {
        number <- "eight"
      }
      else  if (mojrap::as_number(number) == 9) {
        number <- "nine"
      }
      else number

      return(number)
    }


  })

}
