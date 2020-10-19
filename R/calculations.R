#' @title  Calculate base/core figures for a RAP system
#' 
#' @description This function automates to a large extent the common calculations needed for a RAP system. 
#' For example the current and pevious value for a table column/entry as well as rations and percentage differences.
#' Curently 5 categories are included - current values, previous values, numeric change between previous and current quarter values,
#' the ration of the previous and current value and the percentage difference.
#'   
#' 
#' @param table The table to extract information from. This is assumed to be in a dataframe and tidy format. 
#' @param current_pub_year This is the current publication year, usually defined in the begining of your RAP system and need to be passed in the function as well.
#' @param current_pub_quarter The curent publication quarter, 
#' this also is usually defined at the begining of the RAP system
#' 
#' 
#' @return The value returned is a list containing figures per column (of the main dataframe used in the "tables" argument)
#' and per category. More specifically:
#' 
#' tot_cases_current --> contains the current quarter values for each of the columns in the main data frame  
#' 
#' tot_cases_previous --> contains the previous quarter values for each of the columns in the main data frame
#' 
#' tot_cases_change   --> contains the change between the current quarter values and the previous one
#' 
#' tot_cases_ratio   --> contains the ratio of the cahnge current and previous quarter divided by the value  of the previous quarter
#' 
#' tot_cases_perc_change   --> contains the percentage cahnge between the current and previous quarter values     
#' 
#' @examples 
#' 
#' 
#' @export
#' 
#' 
#' 



calculations = function(table, current_pub_year , current_pub_quarter ){
  
  
  tot = list()
  
  if((is.null(table$year) | is.null(table$quarter))) stop("Selected table does not have year or quarter. Use the manual calculations instead.")
  
  
  tot$df_names = colnames(table %>% select(-c("year","quarter")))
  
  # need the values as separate vector to make calculations 
  
  tot$tot_cases_current = table  %>%
    filter(year == pub_year & quarter == paste0("Q",pub_quarter)) %>% as.vector() %>% select(-c("year", "quarter")) %>% 
    as.numeric() %>% enframe()  %>% mutate(name = tot$df_names)
  
  
  tot$tot_cases_previous = table %>%
    filter(year == pub_year-1 & quarter == paste0("Q",pub_quarter)) %>% as.vector() %>% select(-c("year", "quarter")) %>% 
    as.numeric() %>% enframe() %>% mutate(name = tot$df_names)
  
  
  ## further calculations
  
  tot$tot_cases_change = (tot$tot_cases_current$value - tot$tot_cases_previous$value) %>% enframe() %>% 
    mutate(name = tot$df_names)
  
  
  tot$tot_cases_ratio = (tot$tot_cases_change$value/tot$tot_cases_previous$value)
  
  tot$tot_cases_ratio[is.nan(tot$tot_cases_ratio)] <- 0
  
  tot$tot_cases_ratio = tot$tot_cases_ratio %>% enframe() %>% mutate(name = tot$df_names) 
  
  
  tot$tot_cases_perc_change =  map2(tot$tot_cases_previous$value, tot$tot_cases_current$value, format_perc_v2) %>%
    enframe() %>% mutate(name = tot$df_names) 
  
  
  ### set as data frames to export
  
  
  tot$tot_cases_current %<>% deframe() %>% as.matrix() %>% t() %>% as.data.frame() 
  
  tot$tot_cases_previous %<>% deframe() %>% as.matrix() %>% t() %>% as.data.frame() 
  
  tot$tot_cases_change %<>% deframe() %>% as.matrix() %>% t() %>% as.data.frame() 
  
  tot$tot_cases_ratio %<>% deframe() %>% as.matrix() %>% t() %>%  as.data.frame() 
  
  
  tot$tot_cases_perc_change %<>% deframe() %>% as.matrix() %>% t() %>% as.data.frame()
  
  
  
  ## export the list
  ## 
  return(tot)
  
  
}