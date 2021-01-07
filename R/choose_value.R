#' Choose values from a dataframe
#'
#' Returns the value of a given variable from a dataframe for a given time period, and optionally for
#' a given value in an additional column.
#'
#' @param df A dataframe.
#' @param period_col_name Name of the column containing time periods.
#' @param period_val Time period to choose a corresponding value for.
#' @param value_col_name Name of the column containing the variable we want to extract values from.
#' @param additional_col_name An additional variable name to match a value for when selecting a value.
#' @param additonal_val Value of the additional variable to be matched when selecting a value.
#'
#' @return A numeric value or character object.
#
#' @examples
#' df <- data.frame("yrqtr" = c("2015 Q4", "2015 Q4", "2015 Q4", "2016 Q1", "2016 Q1", "2016 Q1"),
#' "type" = c("receipts", "disposals", "outstanding", "receipts", "disposals", "outstanding"),
#' "total" = 1:6
#' )
#'
#' choose_value(df, "yrqtr", "2015 Q4", "total", "type", "outstanding") # returns 3
#'
#' @export

choose_value <- function(df, period_col_name, period_val, value_col_name, additional_col_name = NULL, additonal_val = NULL){

  # Checks on input--------------------------------------

  # Check if df is of type dataframe
  if (!is.data.frame(df)){

    stop("Input to df is not a dataframe")
  }

  # Check period_col_name and value_col_name are all characters
  if (!all(is.character(period_col_name), is.character(value_col_name))){

    stop("period_col_name and value_col_name must be character objects")
  }

  # Check period_col_name is a column in the dataframe
  if(!period_col_name %in% colnames(df)){

    stop("period_col_name is not a column in the dataframe")
  }

  # Check value_col_name is a column in the dataframe
  if(!value_col_name %in% colnames(df)){

    stop("value_col_name is not a column in the dataframe")
  }

  # Check period_val is an actual value in the specified column
  if(period_val %in% df[[period_col_name]] == FALSE){

    stop("The value provided to period_val is not present in the specified column")
  }

  # Check the additional arguments, if supplied

  if (!all(is.null(additional_col_name), is.null(additonal_val))){

    # Check additional_col_name is a character
    if (!(is.character(additional_col_name))){

      stop("additional_col_name must be a character object")
    }

    # Check additional_col_name is a column in the dataframe
    if(!additional_col_name %in% colnames(df)){

      stop("additional_col_name is not a column in the dataframe")
    }

    # Check additonal_val is an actual value in the specified column
    if(additonal_val %in% df[[additional_col_name]] == FALSE){

      stop("The value provided to additonal_val is not present in the specified column")
    }

  }

  # Main body---------------------------------------------

  # Select the relevant columns from the dataframe
  selection <- dplyr::select(df, period_col_name, dplyr::any_of(additional_col_name), value_col_name)

  # Filter for the relevant row(s) based on the value of period_val
  output <- dplyr::filter(selection, .data[[period_col_name]] == period_val)

  # Filter for the relevant row based on additonal_val as well, if required
  if (!is.null(additional_col_name)){
    output <- dplyr::filter(output, .data[[additional_col_name]] == additonal_val)
  }

  # Extract the matched value
  output <- dplyr::pull(dplyr::select(output, value_col_name))

  return(output)

}
