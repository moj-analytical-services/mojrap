#' Returns the next publication date
#'
#' Takes the publication day, week and other parameters and returns the next publication date.
#' Can be used to find previous publications by specifying the months ago parameter. 
#'
#' This will take today's date and find the next publication date for a publication specified using the below parameters. 
#' It does a check to make to make sure that it is not a past date unless backdating is specified.
#'
#' @name pub_date
#'
#' @param pub_day what day of the week is your publication (3 letter starting with capital - Mon, Tue, Wed etc.)
#' @param pub_week which week of the month do you publish (1, 2, 3, 4 or 5 for the last week)
#' @param frequency how often do you publish (monthly, quarterly, annually, biennially)
#' @param first_pub in what month is the first publication of the calendar year (if quarterly this should be 1, 2 or 3)
#' @param bi_start biennial publications only is the year of publication "odd" or "even"
#' @param mago Reduce the date by this many months
#' 
#' @examples
#' pub_date(pub_day = "Thu", pub_week = 2, first_pub = 2, frequency = "quarterly", bi_start = NA , mago = 0)
#' 
#' @export

pub_date <- function(pub_day = 0, pub_week = 0, first_pub = 0, frequency = 0, bi_start = NA , mago = 0) {
  #sets up initial input date determined by publication frequency and backdates if necessary
  #uses find_day to pick out publication date in that month and ensures this is in future (if applicable)
  input_date <- lubridate::today()
  input_date <- backdate_date(input_date, mago)
  interval_amount <- set_interval(frequency)
  if (interval_amount == 3) {
    input_date <- get_quarter(input_date, as.numeric(first_pub))
  } else if (interval_amount == 12) {
    input_date <- get_annual(input_date, as.numeric(first_pub))
  } else if (interval_amount == 1) {
    input_date <- input_date
  } else {
    input_date <- get_biennial(input_date, as.numeric(first_pub), bi_start)
  }
  input_date <- find_day(input_date, as.numeric(pub_week), pub_day)
  #Reruns if given date is not in future (unless specified). 
  if (input_date < lubridate::today()  && mago == 0) {
    input_date <- input_date %m+% months(interval_amount)
    input_date <- find_day(input_date, as.numeric(pub_week), pub_day)
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

backdate_date <- function (input_date, mago){
  #goes back mago months
  new_date <- input_date %m-% months(mago)
  return(new_date)
}

get_quarter <- function(input_date, first_pub){
  #for quarterly pubs establishes month on correct cycle using first_pub
  next_quarter <- ceiling( (lubridate::month(input_date) - first_pub) / 3) * 3 + first_pub
  increase_mon <- next_quarter - lubridate::month(input_date)
  input_date <- input_date %m+% months(increase_mon)
  return(input_date)
}

get_annual <- function(input_date, first_pub){
  #for annual pubs establishes date in correct month
  input_date <- make_date(pub_year, first_pub, lubridate::day(input_date))
  return(input_date)
}

get_biennial <- function(input_date, first_pub, bi_start){
  #for biennial pubs establishes date in correct month and year
  input_year <- lubridate::year(input_date)
  if (bi_start == "even") {
    new_year <- input_year + input_year %% 2
  }
  else {
    new_year <- input_year + (input_year %% 2 + 1) %% 2
  }
  new_date <- make_date(new_year, first_pub, lubridate::day(input_date))
  return(new_date)
}

find_day <- function(input_date, pub_week, pub_day){
  #selects potential publication date using pub_week and pub_day inputs based on established month 
  month_list <- seq(
    lubridate::floor_date(input_date, "month"),
    lubridate::ceiling_date(input_date, "month") - 1,
    by = "1 day")
  day_list <- month_list[lubridate::wday(month_list, label = TRUE) == pub_day]
  pub_week <- min(length(day_list), pub_week)
  new_pub_date <- day_list[pub_week]
  return(new_pub_date)
}