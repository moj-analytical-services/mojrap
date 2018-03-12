#' Picks out selected values from data frame for use in publicatoin commentary
#' @param data Dataset with columns 'period', 'variable' and 'value'
#' @param Period Period to be chosen - in "2016 Q1" or "Q1 2016" format
#' @param Variable Variable of data to be chosen
#
#' @examples 
#' data <- tibble("period" = c("2015 Q4", "2015 Q4", "2015 Q4", "2016 Q1", "2016 Q1", "2016 Q1"),
#' "variable" = c("receipts", "disposals", "outstanding", "receipts", "disposals", "outstanding"),
#' "value" = 1:6
#' )
#'
#' choose_value(data, "2015 Q4", "outstanding")
#'
#' @export

choose_value <- function(data, Period, Variable){
  
  if(check_period_formatting(Period) == 1){
    year <- substr(Period, 4, 7)
    quarter <- substr(Period, 2, 2)
    Period <- paste0(year, " Q", quarter)
  }
  
  output <-data %>%
    dplyr::filter(period == Period, variable == Variable) %>%
    dplyr::select(value) %>%
    as.numeric() %>%
    mojrap::format_num()
  
  return(output)
}
