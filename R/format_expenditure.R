#' Format expenditure
#'
#' Formats a number as an expenditure, e.g. in £m, £k, $m etc. By default, expenditures are rounded to one decimal place in pound sterling,
#' with values below 1 million formatted as £k, and above formatted as £m. This can be overridden by setting the format argument.
#'
#' @param value A number representing an amount of money.
#' @param format Specify as 'm' or 'k' to force the output in millions or thousands, respectively.
#' @param currency A string representing a currency symbol. '£' by default.
#' @param dp A number of decimal places to round expenditures to. By default, set to 1 decimal place.
#'
#' @return A character object representing an expenditure.
#'
#' @examples
#' format_expenditure(36573436) # returns "£36.6m"
#' format_expenditure(356274) # returns "£356.3k"
#' format_expenditure(356274, format = "m") # returns "£0.4m"
#' format_expenditure(3562744, currency = "$") # returns "$3.6m"
#' format_expenditure(4654262.65, currency = "£", dp = 3) #returns "£4.654m"
#'
#' @export

format_expenditure <- function(value, format = NULL, currency = "\u00A3", dp = 1) {

  ### Checks on value

  # Check that value is a number, and raise an error if it isn't
  tryCatch(is.numeric(value),
           error = function(err){
             err$message <- paste("Please provide value as a number")
             stop(err)
           }
  )

  if (is.numeric(value) == FALSE) {
    stop("Input to format_expenditure is not a number")
  }

  # Check that only one value is passed at a time and raise an error otherwise.
  if (length(value) > 1) {

    stop("Please provide a single value to format_expenditure")
  }


  # Check that value is not null, and raise an error if it is
  if  (is.null(value)) {

    stop("Input to format_expenditure is NULL")

  }

  # Check that value is not NA, and raise and error if it is
  if (is.na(value)) {

    stop("Input to format_expenditure is NA")

  }

  ### Checks on format

  # Check that format is "m" or "k", and raise an error if it isn't
  if (!is.null(format)){

    if (format %in% c("m", "k") == FALSE) {
      stop("If specifying the format argument, it must be either 'm' or 'k'")

    }
  }

  ### Checks on dp

  # Check that dp is a string
  if (!is.numeric(dp)){

    stop("Please provide dp as a string")
  }

  # Check that dp is an integer
  if (dp %% 1 != 0){

    stop("Please provide dp as an integer")
  }

  # If checks of function pass, then run the main body of the function, and
  # return and output.

  ## MAIN BODY--------------------------------------------------------------

  if (is.null(format)){

    if (abs(value) < 1000000) {

      value <- paste(currency,(round(abs(as.numeric(formattable::comma(value))/1000), dp))
                              , "k", sep = "")
      return(value)

    }

    else if (abs(value) >= 1000000) {

      value <- paste(currency,(round(abs(as.numeric(formattable::comma(value))/1000000), dp))
                     , "m", sep = "")
      return(value)

    }

  }

  else if (format == 'm') {

    value <- paste(currency,(round(abs(as.numeric(formattable::comma(value))/1000000), dp))
                   , "m", sep = "")
    return(value)


  }

  else if (format == 'k') {

    value <- paste(currency,(round(abs(as.numeric(formattable::comma(value))/1000), dp))
                   , "k", sep = "")
    return(value)

  }

}
