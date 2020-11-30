#' Convert dates to publication quarters
#'
#' @description Function converting dates to publication quarters
#'
#' @param date Date in the form of 'YYYY-MM-DD'
#' @param type Input 1 for calendar quarter or 4 for financial quarter
#
#' @examples
#' mojquarter('2020-03-31', 4)
#'
#' @return Either a calendar or financial quarter
#'
#' @export

mojquarter <- function(date, type) {
  if(type == 1) {
    return(paste0(as.numeric(substr(date, 1, 4)),"q",lubridate::quarter(date,fiscal_start = type)))
  }

  else if(type == 4) {
    year <- ifelse(dplyr::between(lubridate::month(date), 1, 3),
                   as.numeric(substr(date, 1, 4)) - 1,
                   as.numeric(substr(date, 1, 4)))

    return(paste0(year,"q",lubridate::quarter(date,fiscal_start = type)))
  }

  else
  {return(paste0("Please enter date in the form of 'YYYY-MM-DD' and in the other parameter, enter 1 for calendar quarter or 4 for financial quarter"))}
}
