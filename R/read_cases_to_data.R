# read_cases_to_data
#
#' @title Read case-level SAS or CSV file from S3 into an aggregated dataset
#
#' @description Reads in a case-level SAS or CSV file stored in S3 and aggregates it by a vector of specified variables.
#' Adds a variable called 'count' to the dataset to indicate the number of cases in each variable group.
#
#
#' @param format Format of the dataset in S3 (either "SAS" or "CSV"). NB Case insensitive input.
#' @param path Path to file in S3.
#' @param varlist A character vector of variables by which to aggregate the data.
#'
#' @examples
#' \dontrun{
#' read_cases_to_data("SAS","alpha-test-data/popdata.sas7bdat",c("sex","age","region"))
#' # returns a tibble with variables sex, age, region and count.
#' }
#' @export
#'

read_cases_to_data <- function(format,path,varlist) {

  # Checks on arguments-------------------------------

  if (length(format) > 1) {

    stop("Argument 'format' must have length 1")

  } else if (!tolower(format) %in% c("sas","csv")) {

    stop("format should be 'SAS' or 'CSV'")

  } else if (length(path) > 1) {

    stop("Argument 'path' must have length 1")

  } else if (!is.character(path)) {

    stop("Argument 'path' must be of type character")

  } else if (!is.character(varlist)) {

    stop("Argument 'varlist' must be a character vector")

  }

  # MAIN BODY------------------------------------------------------------------

  # Read dataset depending on format

  if (tolower(format) == "sas") {

    data <- Rs3tools::read_using(FUN = haven::read_sas,
                                 s3_path = path)

    data[] <- lapply(data, as.character)

  } else if (tolower(format) == "csv") {

    data <- Rs3tools::read_using(FUN = readr::read_csv,
                                s3_path = path,
                                col_types = readr::cols(.default = "c"))

  }

  # Aggregate by variable list

  data <- data %>%
          tibble::as_tibble() %>%
          dplyr::group_by(!!!rlang::syms(varlist)) %>%
          dplyr::summarise(count = dplyr::n())

  # Return dataset with lower case names (aids consistency across datasets)

  names(data) <- tolower(names(data))

  return(data)

}


