#' Describe changes over a given time period
#'
#' Returns a character string describing whether a variable from a dataframe has either increased, decreased, or stayed
#' the same over a given period of time.
#'
#' @param df A dataframe.
#' @param var_name The name of the variable to calculate the change for, as a string.
#' @param date_col The name of the column containing time periods, as a string.
#' @param base_date The base date to calculate the change between.
#' @param second_date The second date to calculate the change between.
#'
#' @return A character object.
#'
#' @examples
#'
#' df <- data.frame("yrqtr" = c("2020 Q1", "2020 Q2", "2020 Q3", "2020 Q4"),
#' "receipts" = c(10,4,5,10)
#' )
#'
#' change_desc(df, "receipts", "yrqtr", "2020 Q2", "2020 Q3") # returns "increased"
#' change_desc(df, "receipts", "yrqtr", "2020 Q1", "2020 Q2") # returns "decreased"
#' change_desc(df, "receipts", "yrqtr", "2020 Q1", "2020 Q4") # returns "did not change"
#'
#' @export

change_desc <- function(df, var_name, date_col, base_date, second_date){

  # Checks on input arguments------------------------------------

  ### df checks

  # Check if df is of type dataframe
  if (!is.data.frame(df)){

    stop("Input to df is not a dataframe")
  }

  ### var_name checks

  if (!is.character(var_name)){

    stop("Please provide var_name as a string")
  }

  # Check var_name is one of the variables in the dataframe
  if(var_name %in% colnames(df) == FALSE){

    stop("The variable specified in var_name is not present in the dataframe")
  }

  ### date_col checks

  # Check if the column name given to date_col is a string

  if (!is.character(date_col)){

    stop("Please provide the column name in date_col as a string")
  }

  # Check the column name given to date_col is a column in the dataframe
  if(!date_col %in% colnames(df)){

    stop("The column name provided for the date column is not in the dataframe")
  }

  ### base_date checks

  # Check if base_date is NA/NaN

  if(is.na(base_date)){

    stop("NA/NaN value has been provided to base_date")
  }

  # Check the value given to base_date is an actual value in the specified column
  if(base_date %in% df[[date_col]] == FALSE){

    stop("The value provided to base_date is not in the specified date column")
  }

  ### second_date checks

  # Check if second_date is NA/NaN

  if(is.na(second_date)){

    stop("NA/NaN value has been provided to second_date")
  }

  # Check the value given to second_date is an actual value in the specified column
  if(second_date %in% df[[date_col]] == FALSE){

    stop("The value provided to second_date is not in the specified date column")
  }

  # MAIN BODY---------------------------------------------------------------------------

  # check if the change is an NA or NaN
  if(is.na(change(df, var_name, date_col, base_date, second_date))){
    stop("The change in the variable given the parameters provided is NA/NaN")
  }

  if(change(df, var_name, date_col, base_date, second_date) > 0){

    return("increased")
  }

  else if(change(df, var_name, date_col, base_date, second_date) < 0){

    return("decreased")

  }

  else if(change(df, var_name, date_col, base_date, second_date) == 0){

    return("did not change")

  }

}
