#' Calculate changes over a given time period
#'
#' Calculates either the absolute or percentage change in a given variable over a certain period of time.
#'
#' @param df A dataframe.
#' @param var_name The name of the variable to calculate the change for, as a string.
#' @param date_col The name of the column containing time periods, as a string.
#' @param base_date The base date to calculate the change between.
#' @param second_date The second date to calculate the change between.
#' @param type Specify either an "absolute" or a "percentage" change. Defaults to "absolute".
#'
#' @return A numeric value.
#'
#' @examples
#'
#' df <- data.frame("yrqtr" = c("2020 Q1", "2020 Q2", "2020 Q3", "2020 Q4"),
#' "receipts" = seq(10, 40, 10)
#' )
#'
#' change(df, "receipts", "yrqtr", "2020 Q2", "2020 Q4") # returns 20
#' change(df, "receipts", "yrqtr", "2020 Q2", "2020 Q4", type = "percentage") # returns "100%"
#' @export

change <- function(df, var_name, date_col, base_date, second_date, type = "absolute"){

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

  # Check the value given to base_date is an actual value in the specified column
  if(second_date %in% df[[date_col]] == FALSE){

    stop("The value provided to second_date is not in the specified date column")
  }

  ### type checks

  # Check the type argument is correct
  if (!type %in% c("absolute", "percentage")){

    stop("The type argument must be either 'absolute' or 'percentage', to specify the type of change calculated")
  }

  # MAIN BODY-------------------------------------------------------------------

  # Extract the required values from the dataframe
  base_val <- choose_value(df, var_name, date_col, base_date)
  second_val <- choose_value(df, var_name, date_col, second_date)

  # Calculate the absolute change and return it

  if (type == "absolute"){

    diff <- second_val - base_val
    return(diff)

    # Alternatively, calculate the percentage change and return it

  } else if (type == "percentage") {

    diff <- (second_val - base_val) / base_val
    if (is.infinite(diff)){

      stop("Error: the percentage change from a zero value is not defined")
    }
    perc <- format_perc(diff)
    return(perc)

  }

}

