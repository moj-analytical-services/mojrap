#' Choose a value from a dataframe
#'
#' Returns the value of a variable in a dataframe, for a given value of another variable (or 2 variables) in the dataframe.
#'
#' @param df A dataframe.
#' @param col_name Name of the variable we want to extract a value from (as a string).
#' @param col_val_1 A vector containing the name (as a string) and value, in that order, of a variable used to filter the dataframe.
#' @param col_val_2 A vector containing the name (as a string) and value, in that order, of an additional variable used to filter the dataframe, if required.
#'
#' @return A numeric value or character object.
#
#' @examples
#' df1 <- data.frame("yrqtr" = c("2015 Q4", "2015 Q4", "2015 Q4", "2016 Q1", "2016 Q1", "2016 Q1"),
#' "type" = c("receipts", "disposals", "outstanding", "receipts", "disposals", "outstanding"),
#' "total" = 1:6
#' )
#'
#' df2 <- data.frame("yrqtr" = c("2020 Q1", "2020 Q2", "2020 Q3", "2020 Q4"),
#' "receipts" = seq(10, 40, 10)
#' )
#'
#' choose_value(df1, "total", c("yrqtr", "2015 Q4"), c("type", "receipts")) # returns 1
#' choose_value(df2, "receipts", c("yrqtr", "2020 Q1")) # returns 10
#'
#' @export

choose_value <- function(df, col_name, col_val_1, col_val_2 = NULL){

  # Checks on input-------------------------------------------------

  ### df checks

  # Check if df is of type dataframe
  if (!is.data.frame(df)){

    stop("Please provide df as a dataframe")
  }

  ### col_name checks

  # Check col_name is a string
  tryCatch(is.character(col_name),
           error = function(err){
             err$message <- paste("Please provide col_name as a string")
             stop(err)
             }
    )

  if (!is.character(col_name)){
    stop("Please provide col_name as a string")
  }

  # Check col_name is a column in the dataframe
  if(!col_name %in% colnames(df)){

    stop("col_name is not a column in the dataframe")
  }

  ### col_val_1 checks

  # Check if the column name given to col_val_1 is a string
  tryCatch(is.character(col_val_1[1]),
           error = function(err){
             err$message <- paste("Please provide the column name in col_val_1 as a string")
             stop(err)
           }
  )

  if (!is.character(col_val_1[1])){
    stop("Please provide the column name in col_val_1 as a string")
  }

  # Check a vector of length 2 is given to col_val_1
  if(length(col_val_1) != 2){

    stop("Please provide two values to vector col_val_1: first the column name, second a value in that column")
  }

  # Check the column name given to col_val_1 is a column in the dataframe
  if(!col_val_1[1] %in% colnames(df)){

    stop("The column name given to col_val_1 is not a column in the dataframe")
  }

  # Check the value given to col_val_1 is an actual value in the specified column
  if(col_val_1[2] %in% df[[col_val_1[1]]] == FALSE){

    stop("The value provided to col_val_1 is not present in the specified column")
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

  # MAIN BODY-----------------------------------------------------------------------

  # Select the relevant columns from the dataframe
  selection <- dplyr::select(df, col_val_1[1], col_val_2[1], col_name)

  # Filter for the relevant row(s) based on the value of col_val_1
  output <- dplyr::filter(selection, .data[[col_val_1[1]]] == col_val_1[2])

  # Filter for the relevant row based on col_val_2 as well, if required
  if (!is.null(col_val_2)){
    output <- dplyr::filter(output, .data[[col_val_2[1]]] == col_val_2[2])
  }

  # Extract the matched value
  output <- dplyr::pull(dplyr::select(output, col_name))

  # Warning if more than one row is returned
  if (length(output) > 1){
    warning("More than one value has been found matching the supplied parameters")
  }

  # Return the matched value
  return(output)

}
