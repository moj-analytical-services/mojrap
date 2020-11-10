# date_type
#
#' This function takes standard number format and returns a number format of the users choosing
#' @param date standard number format
#' @param type specifies the format that the date should be returned in. Standared R date types.
#' @examples date_type("2012-12-31", "%Y")  # returns 2012
#' @export
#'


date_type <- function(date, type) {

  tryCatch({

    # Check that only one value is passed to format_perc() at a time and raise
    # an error otherwise.

    if  (is.null(date)) {

      # Check that input is not null, and raise an error if it is

      stop("Input to date_type is NULL", call. = FALSE)

    } else if (is.na(date)) {

      # Check that input is not null, and raise and error if it is

      stop("Input to date_type is NA", call. = FALSE)

    } else if (!is.character(date)) {

      stop("Input to date_type is not a character", call. = FALSE)

    } else {

      # If checks of function pass, then run the main body of the function, and
      # return and output.


# BODY --------------------------------------------------------------------



  format(as.Date(date, format = "%Y-%m-%d"), format = type)

    }

  }, warning = function(war){
    warning(war)

  }, error = function(err){

    err$message <- paste("While extracting the preferred date format", err, sep = " ")
    stop(err)
  })

}
