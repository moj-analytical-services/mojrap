#' Choose a value from a dataframe
#'
#' Returns the value of a variable in a dataframe, for a given value of another variable in the dataframe.
#'
#' @param df A dataframe.
#' @param var_name Name of the variable we want to extract a value from, as a string.
#' @param additional_name The name of a column used to filter the dataframe on, as a string.
#' @param additional_value A value in the column to filter the dataframe for.
#'
#' @examples
#'
#' df <- data.frame("yrqtr" = c("2020 Q1", "2020 Q2", "2020 Q3", "2020 Q4"),
#' "receipts" = seq(10, 40, 10)
#' )
#'
#' choose_value(df, "receipts", "yrqtr", "2020 Q1") # returns 10
#'
#'
#' @export
#'
#' @importFrom rlang .data


choose_value <- function(df, var_name, additional_name, additional_value){

  # Checks on input arguments-------------------------------------------------

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

  ### additional_name checks

  # Check a single value is provided to additional_name
  if(length(additional_name) != 1){
    stop("Please provide a single column name to additional_name as a string")
  }

  # Check if the column name given to date_col is a string

  if (!is.character(additional_name)){
    stop("Please provide the column name in additional_name as a string")
  }

  # Check the column name given to date_col is a column in the dataframe
  if(!additional_name %in% colnames(df)){

    stop("The column name provided for additional_name is not in the dataframe")
  }

  ### additional_value checks

  # Check if additional_value is NA/NaN

  if(is.na(additional_value)){

    stop("NA/NaN value has been provided to additional_value")
  }

  # Check a single value is provided to additional_value
  if(length(additional_value) != 1){
    stop("Please provide a single value to additional_value")
  }

  # Check the value given to additional_value is an actual value in the specified column
  if(additional_value %in% df[[additional_name]] == FALSE){

    stop("The value provided to additional_value is not in the specified date column")
  }

  # MAIN BODY-----------------------------------------------------------------------

  # Select the relevant columns from the dataframe
  selection <- dplyr::select(df, var_name, additional_name)

  # Filter for the relevant row(s) based on the value of additional_value
  output <- dplyr::filter(selection, .data[[additional_name]] == additional_value)

  # Extract the matched value
  output <- dplyr::pull(dplyr::select(output, var_name))

  # Warning if more than one row is returned
  if (length(output) > 1){
    warning("More than one value has been found matching the supplied arguments")
  }

  # Return the matched value
  output

}
