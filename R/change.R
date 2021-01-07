#' Calculate changes over a given time period
#'
#' Calculates either the absolute or percentage change in a given variable over a given period of time.
#'
#' @param df A dataframe.
#' @param col_name Variable name from the dataframe to calculate the change for.
#' @param val Chosen value of the variable to calculate the change for. NB the first instance of the value in the column is matched.
#' @param ago The number of time intervals ago, e.g. quarters or years, to calculate the change from. An integer.
#' @param type Specify either an "absolute" or "percentage" change.
#'
#' @return A numeric value.
#'
#' @examples
#' df <- data.frame("period" = c("2020 Q1", "2020 Q2", "2020 Q3", "2020 Q4"),
#' "receipts" = seq(10, 40, 10)
#' )
#' change(df, "receipts", 40, 2) # returns 20
#' change(df, "receipts", 40, 1, type = "percentage") # returns "33%"
#'
#' @export

change <- function(df, col_name, val, ago, type = "absolute"){

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

    stop("The column specified in col_name is not present in the dataframe")
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

  # Check the type argument is correct
  if (!type %in% c("absolute", "percentage")){

    stop("The type argument must be either 'absolute' or 'percentage'")
  }

  # Main body---------------------------------------

  # Extract specified column
  col <- df[[col_name]]

  # Find index of given value in specified column
  pos <- match(val, col)

  # Error if a negative index is chosen
  if (pos - ago < 0) {

    stop("The number of time intervals ago exceeds what is available in the data.")
    }

  # Calculate absolute change
  if (type == "absolute"){

    diff <- col[pos] - col[pos-ago]
    return(diff)

  # Calculate percentage change
  } else if (type == "percentage") {

    diff <- (col[pos] - col[pos-ago]) / col[pos-ago]
    perc <- format_perc(diff)
    return(perc)

  }

}

