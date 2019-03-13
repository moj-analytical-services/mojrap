library(lubridate)

# pub_date
#
#' Takes the publication name and returns the next publication date
#
#' This will take the name and the date and find the next publication date on a thursday.  
#' It does a check to make to make sure that it is not a past date unless manual overwritten.
#' @param pub_day what day of the week is your publication (3 letter starting with capital - Mon, Tue, Wed etc.)
#' @param pub_week which week of the month do you publish (1, 2, 3, 4 or 5 for the last week)
#' @param pub_month for annual and biennial what month is your publication
#' @param frequency how often do you publish (monthly, quarterly, annually, biennially)
#' @param calendar for quarterly pubs (TRUE if data uses calendar quarters, FALSE if financial)
#' @param firstpub for quarterly pubs month of first publication of the year (1, 2 or 3)
#' @param delay for quarterly pubs (number of months between starting month of data quarter and pub month)
#' @param bi_start biennial publications only is the year of publication "odd" or "even"
#' @param mago Reduce the date by this many months
#' @param manual_date Add the starting date.  If blank, the current date (i.e, today()) will be used [to be removed]

#' @examples
#' Need to set examples here
#'
#' @export

pub_date <- function(pub_day = 0, pub_week = 0, pub_month = 0, frequency = 0, calendar = TRUE, 
                     firstpub = 0, delay = 0, bi_start = NA , mago = 0, manual_date = 0) {
  input_date <- mpub_date(manual_date)
  input_date <- backdate_date(input_date, mago)
  interval_amount <- set_interval(frequency)
  if (interval_amount == 3) {
    input_date <- get_quarter(input_date, as.numeric(firstpub))
  } else if (interval_amount == 12) {
    input_date <- get_annual(input_date, as.numeric(pub_month))
  } else {
    input_date <- get_biennial(input_date, as.numeric(pub_month), bi_start)
  }
  input_date <- find_day(input_date, as.numeric(pub_week))
  #I can only see it being a past date if in the same month.  Therefore this reruns under that
  if (input_date < today()  && mago + manual_date == 0) {
    input_date <- input_date %m+% months(interval_amount)
    input_date <- find_day(input_date, as.numeric(pub_week))
  }
  return(input_date)
}

set_interval <- function(frequency){
  #convert the word to it's unit of measurement
  if (frequency == "quarterly"){
      interval_amount <- 3
    } else if (frequency == "annually"){
      interval_amount <- 12
    } else if (frequency == "monthly"){
      interval_amount <- 1
    } else {
      interval_amount <- 24
    }
  return(interval_amount)
}

mpub_date <- function(manual_date){
  #Manual override the date otherwise use the current date
  if (manual_date != 0) {
    input_date <- manual_date_overide(manual_date)
  }
  else{
    input_date <- today()
  }
  return(input_date)
}

manual_date_overide <- function (manual_date){
  new_date <- dmy(manual_date)
  return(new_date)
}

backdate_date <- function (input_date, mago){
  new_date <- input_date %m-% months(mago)
  return(new_date)
}

get_quarter <- function(input_date, firstpub){
  next_quarter <- ceiling( (month(input_date) - firstpub) / 3) * 3 + firstpub
  increase_mon <- next_quarter - month(input_date)
  input_date <- input_date %m+% months(increase_mon)
  return(input_date)
}

get_annual <- function(input_date, pub_month){
  if (month(input_date) < pub_month) {
    pub_year <- year(input_date)
  }
  else{
    pub_year <- year(input_date) + 1
  }
  input_date <- make_date(pub_year, pub_month, day(input_date))
  return(input_date)
}

get_biennial <- function(input_date, pub_month, bi_start){
  input_year <- year(input_date)
  if (bi_start == "even") {
    new_year <- input_year + input_year %% 2
  }
  else {
    new_year <- input_year + (input_year %% 2 + 1) %% 2
  }
  new_date <- make_date(new_year, pub_month, day(input_date))
  return(new_date)
}

find_day <- function(input_date, pub_week, pub_day){
  month_list <- seq(
    floor_date(input_date, "month"),
    ceiling_date(input_date, "month") - 1,
    by = "1 day")
  day_list <- month_list[wday(month_list, label = TRUE) == pub_day]
  pub_week <- min(length(day_list), pub_week)
  new_pub_date <- day_list[pub_week]
  return(new_pub_date)
}

#To remove? - not included in output

get_current_q <- function(input_date, delay, calendar){
  if (calendar == FALSE) {
    delay <- delay + 3
    }
  current_quarter <- (month(input_date %m-% months(delay)) - 1) %/% 3 + 1
  return(current_quarter)
}

get_next_q <- function(current_quarter){
  next_quarter <- current_quarter %% 4 + 1
  return(next_quarter)
}

get_previous_q <- function(current_quarter){
  previous_quarter <- (current_quarter - 1)
  if (previous_quarter == 0) {
    previous_quarter <- 4
    }
  return(previous_quarter)
}