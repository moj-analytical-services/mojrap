#' Describe changes over a given time period
#'
#' Returns a character string describing whether a variable has increased or decreased over a given period of time.
#'
#' @param df A dataframe.
#' @param col_name The name of the variable to describe the change for as a string.
#' @param col_vals_1 A vector specifying the name of the column containing time periods (as a string) and the two corresponding values you want to describe a change between.
#' @param col_val_2 A vector containing an additional column name (as a string) and value used to filter table rows on, if required.
#'
#' @return A character object.
#'
#' @examples
#' df1 <- data.frame("yrqtr" = c("2015 Q4", "2015 Q4", "2015 Q4", "2016 Q1", "2016 Q1", "2016 Q1"),
#' "type" = c("receipts", "disposals", "outstanding", "receipts", "disposals", "outstanding"),
#' "total" = c(3,2,10,1,5,10)
#' )
#'
#' df2 <- data.frame("yrqtr" = c("2020 Q1", "2020 Q2", "2020 Q3", "2020 Q4"),
#' "receipts" = c(10,4,5,10)
#' )
#'
#' change_desc(df2, "receipts", c("yrqtr", "2020 Q2", "2020 Q3")) # returns "increased"
#' change_desc(df2, "receipts", c("yrqtr", "2020 Q1", "2020 Q2")) # returns "decreased"
#' change_desc(df2, "receipts", c("yrqtr", "2020 Q1", "2020 Q4")) # returns "did not change"
#' change_desc(df1, "total", c("yrqtr", "2015 Q4", "2016 Q1"), c("type", "disposals"))
#' # returns "increased"
#' change_desc(df1, "total", c("yrqtr", "2015 Q4", "2016 Q1"), c("type", "receipts"))
#' # returns "decreased"
#' change_desc(df1, "total", c("yrqtr", "2015 Q4", "2016 Q1"), c("type", "outstanding"))
#' # returns "did not change"
#'
#' @export

change_desc <- function(df, col_name, col_vals_1, col_val_2 = NULL){

  # Checks on input------------------------------------

  ### df checks

  # Check if df is of type dataframe
  if (!is.data.frame(df)){

    stop("Input to df is not a dataframe")
  }

  ### col_name checks

  # Check col_name is a character

  tryCatch(is.character(col_name),
           error = function(err){
             err$message <- paste("Please provide col_name as a string")
             stop(err)
           }
  )

  if (!is.character(col_name)){

    stop("Please provide col_name as a string")
  }

  # Check col_name is one of the columns in the dataframe
  if(col_name %in% colnames(df) == FALSE){

    stop("The column specified in col_name is not present in the dataframe")
  }

  ### col_vals_1 checks

  # Check if the column name given to col_vals_1 is a string

  tryCatch(is.character(col_vals_1[1]),
           error = function(err){
             err$message <- paste("Please provide the column name in col_vals_1 as a string")
             stop(err)
           }
  )

  if (!is.character(col_vals_1[1])){
    stop("Please provide the column name in col_vals_1 as a string")
  }

  # Check a vector of length 3 is given to col_vals_1
  if(length(col_vals_1) != 3){

    stop("Please provide three values to vector col_vals_1: first the column name, second a value in that column, third another value in that column")
  }

  # Check the column name given to col_vals_1 is a column in the dataframe
  if(!col_vals_1[1] %in% colnames(df)){

    stop("The first element provided to col_vals_1 is not a column name in the dataframe")
  }

  # Check the first value given to col_vals_1 is an actual value in the specified column
  if(col_vals_1[2] %in% df[[col_vals_1[1]]] == FALSE){

    stop("The second element provided to col_vals_1 is not a value in the specified column")
  }

  # Check the second value given to col_vals_1 is an actual value in the specified column
  if(col_vals_1[3] %in% df[[col_vals_1[1]]] == FALSE){

    stop("The third element provided to col_vals_1 is not a value in the specified column")
  }

  ### col_val_2 checks, if supplied

  # Check if the column name given to col_val_2 is a string
  tryCatch(!is.null(col_val_2) == TRUE & is.character(col_val_2[1]),
           error = function(err){
             err$message <- paste("Please provide the column name in col_val_2 as a string")
             stop(err)
           }
  )

  if (!is.null(col_val_2)){

    # Check a vector of length 2 is given to col_val_2
    if(length(col_val_2) != 2){

      stop("Please provide two values to vector col_val_2: first the column name, second a value in that column")
    }

    # Check if the column name given to col_val_2 is a string

    if (!is.character(col_val_2[1])){
      stop("Please provide the column name in col_val_2 as a string")
    }

    # Check the column name given to col_val_2 is a column in the dataframe
    if(!col_val_2[1] %in% colnames(df)){

      stop("The column name given to col_val_2 is not a column in the dataframe")
    }

    # Check the value given to col_val_1 is an actual value in the specified column
    if(col_val_2[2] %in% df[[col_val_2[1]]] == FALSE){

      stop("The value provided to col_val_2 is not present in the specified column")
    }

  }

  # MAIN BODY----------------------------------------

  if(change(df, col_name, col_vals_1, col_val_2) > 0){

    return("increased")
  }

  else if(change(df, col_name, col_vals_1, col_val_2) < 0){

    return("decreased")

  }

  else if(change(df, col_name, col_vals_1, col_val_2) == 0){

    return("did not change")

  }

}
