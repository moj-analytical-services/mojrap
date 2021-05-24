# add lookups
#
#' @title Add values from a lookup file stored in S3 to a dataset
#
#' @description Takes a vector of lookup files stored as CSVs in S3 and matches them to a data frame by a corresponding vector of variables. The file and variable names must be in the same position in their respective vectors and both vectors must be the same length.
#
#' @param data Data frame the lookups are to be added to
#' @param path A vector of paths to lookup files in S3
#' @param vars A vector of variables by which to join the lookups to the data
#'
#' @examples
#' add_lookups(mydata,"alpha-test-data/lookup-file.csv","regionname") # joins lookup-file.csv to mydata by variable "regionname".
#' @export
#'


add_lookups <- function(data,path,vars){

  if (length(path) != length(vars)){

    stop("Argument 'path' and argument 'vars' must be the same length.")

  } else if (!is.character(path)) {

    stop("Argument 'path' must be a character vector")

  } else if (!is.character(vars)) {

    stop("Argument 'vars' must be a character vector")

  }

  for (i in 1: length(path)) {

    lookup <- s3tools::read_using(FUN = readr::read_csv,
                                s3_path = path[i],
                                col_types = cols(.default = "c"))

    data <- dplyr::left_join(data,lookup,by = vars[i])

  }

  return(data)

}
