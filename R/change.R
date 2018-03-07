#' Calculates the change in a given variable over a given period
#' @param df Dataset with column called "variable"
#' @param x Chosen value from "variable" column
#' @param y A number greater than 0. This is the number of quarters ago,
#' that you want to calculate change from.
#' @param z Absolute or percentage change.
#' @export

change <- function(df, x, y, z = "absolute"){
  (
    (df %>%
     filter(variable == x) %>%
     filter(row_number() == n()) %>%
     .$value) -
    (df %>%
       filter(variable == x) %>%
       filter(row_number() == n()-y) %>%
       .$value)
    )/
    if(z == "absolute"){
      1
      } else if(z== "percentage"){
        (df %>%
         filter(variable == x) %>%
         filter(row_number() == n()-y) %>%
         .$value/100)
    }
     }
