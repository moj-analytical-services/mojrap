#' Describe changes over a given period
#'
#' Returns a character string describing whether a variable has increased or decreased over a given period of time.
#'
#' @param df A dataframe.
#' @param col_name Variable name from the dataframe to calculate the change for.
#' @param val Chosen value of the variable to calculate the change for.
#' @param ago The number of quarters ago for quarterly data,
#' or years ago for yearly data, that you want to calculate the change from.
#'
#' @return A character object.
#'
#' @examples
#' df <- data.frame("period" = c("2019 Q4", "2020 Q1", "2020 Q2", "2020 Q3", "2020 Q4"),
#' "receipts" = c(100, seq(10, 40, 10))
#' )
#' change_desc(df, "receipts", 40, 2) # returns "increased"
#' change_desc(df, "receipts", 40, 4) # returns "decreased"
#'
#' @export

change_desc <- function(df, col_name, val, ago){

  # Checks on input------------------------------------

  # Check if df is of type dataframe
  if (!is.data.frame(df)){

    stop("Input to df is not a dataframe")
  }

  # Check col_name is a character
  if (!is.character(col_name)){

    stop("col_name must be a character object")
  }

  # Check col_name is one of the columns in the dataframe
  if(col_name %in% colnames(df) == FALSE){

    stop("The column specified in col_name is not present")
  }

  # Check value is numeric
  if(!is.numeric(val)){

    stop("The value provided to val must be numeric")
  }

  # Check val is an actual value in the column
  if(val %in% df[[col_name]] == FALSE){

    stop("The value provided to val is not present in the specified column")
  }

  # Check ago is an integer
  if (ago %% 1 != 0){

    stop("The value provided to ago must be an integer")
  }

  # Main body----------------------------------------

  if(change(df, col_name, val, ago) > 0){

    return("increased")
  }

  else if(change(df, col_name, val, ago) < 0){

    return("decreased")

  }

}
