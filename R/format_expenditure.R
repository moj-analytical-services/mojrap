#' @title Format expenditure
#'
#' @description Convert value to amount for publication. By default, the expenditure format is in £m with 1 decimal place.
#'
#' @details Generic method to convert value into a £m, £k, $m etc.
#'
#' @param value An amount of expenditure in
#' @param format Whether the expenditure is written in millions (m) or thousands (k). Default: millions
#' @param currency Default: £'s
#' @param dp Number of decimal places to round expenditure to. Default: 1 decimal place
#'
#' @return A character object.
#'
#' @examples
#'
#' format_expenditure(36573436) #returns £36.6m
#' format_expenditure(3562744, currency = "$") #returns $3.6m
#' format_expenditure(3562744, format = "k") #returns £3562.7k
#' format_expenditure(4654262.65, currency = "£", dp = 3) #returns £4.654m
#'
#' @export



format_expenditure <- function(value, format = "m", currency = "\u00A3", dp = 1) {

  tryCatch({

    # Check that only one value is passed to format_perc() at a time and raise
    # an error otherwise.

    if (length(value) > 1) {

      stop(
        "Input to format_expenditure is not a single value. ",
        "Most likely you have tried to pass a vector, ",
        "list, or df to format_expenditure()",
        call. = FALSE
      )

    } else if  (is.null(value)) {

      # Check that value is not null, and raise an error if it is

      stop("Input to format_expenditure is NULL", call. = FALSE)

    } else if (is.na(value)) {

      # Check that value is not null, and raise and error if it is

      stop("Input to format_expenditure is NA", call. = FALSE)

    } else if (is.numeric(value) == FALSE) {
      # Check that value is a number, and raise an error if it isn't
      stop("Input to format_expenditure is not a number", call. = FALSE)

    }  else if (format %in% c("m", "k") == FALSE) {
      # Check that format is "m" or "k", and raise an error if it isn't
      stop("The format argument is not either 'm' or 'k'", call. = FALSE)

    } else if (format == 'm') {

      # If checks of function pass, then run the main body of the function, and
      # return and output.

      value <- paste(currency,(round(abs(as.numeric(formattable::comma(value))/1000000), dp))
                     , "m", sep = "")
      return(value)


    } else if (format == 'k') {

      # If checks of function pass, then run the main body of the function, and
      # return and output.

      value <- paste(currency,(round(abs(as.numeric(formattable::comma(value))/1000), dp))
                     , "k", sep = "")
      return(value)


    }
  }
  , warning = function(war){
    warning(war)

  }
  , error = function(err){

    err$message <- paste("While formatting expenditure", err, sep = " ")
    stop(err)
  })
}
