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
#' @param first_pub in what month is the first publication of the calendar year (if quarterly this should be 1, 2 or 3)
#' @param frequency how often do you publish (monthly, quarterly, annually, biennially)
#' @param bi_start biennial publications only is the year of publication "odd" or "even"
#' @param mago Reduce the date by this many months
#' The following 2 are only set when testing
#' @param input_date defaults to today's date, however for testing purposes can be changed to an arbitrary date
#' @param test set to TRUE when testing the function, otherwise defaults to FALSE
#' 
#' @examples
#' pub_date(pub_day = "Thu", pub_week = 2, first_pub = 2, frequency = "quarterly", bi_start = NA , mago = 0)
#' 
#' @export

# MAIN BODY ----------------------

pub_date <- function(pub_day, pub_week, first_pub, frequency, bi_start = NA , mago = 0, input_date=lubridate::today(), test=FALSE) {
  #sets up initial input date determined by publication frequency and backdates if necessary
  #uses find_day to pick out publication date in that month and ensures this is in future (if applicable)

  if (is.na(as.Date(input_date, format="%Y-%m-%d")) == TRUE){
    stop("Your input_date input must be a calender date in ISO 8601 format: 'YYYY-MM-DD'")
  }
  
  if (pub_day %in% c("Mon","Tue","Wed","Thu","Fri","Sat","Sun") == FALSE){
    stop("Your pub_day input must be a 3 letter day starting with a capital e.g. Mon")
    }
  
  if (pub_week %in% c(1,2,3,4,5) == FALSE){
    stop("Your pub_week input must be 1, 2, 3, 4 or 5")
    }
  
  if (first_pub %in% c(1,2,3,4,5,6,7,8,9,10,11,12) == FALSE){
    stop("Your first_pub input must be a number between 1 and 12")
    }
  
  if (frequency %in% c("monthly","quarterly","annually","biennially") == FALSE){
    stop("Your frequency input must be monthly, quarterly, annually or biennially")
    }
  
  if (bi_start %in% c("odd","even",NA) == FALSE){
    stop("Your bi_start input must be odd, even or NA")
    }
  
  if (is.numeric(mago) == FALSE || mago < 0){
    stop("Your mago input must be a number greater than or equal to zero")
    }
  
  input_date <- as.Date(input_date)
  input_date <- backdate_date(input_date, mago)
  interval_amount <- set_interval(frequency)
  if (interval_amount == 3) {
    input_date <- get_quarter(input_date, as.numeric(first_pub))
  } else if (interval_amount == 12) {
    input_date <- get_annual(input_date, as.numeric(first_pub))
  } else if (interval_amount == 1) {
    input_date <- input_date
  } else if (interval_amount == 24) {
    input_date <- get_biennial(input_date, as.numeric(first_pub), bi_start)
  }
  input_date <- find_day(input_date, as.numeric(pub_week), pub_day)
  #Reruns if given date is not in future (unless specified), but only when NOT in testing mode
  if (test == FALSE){
    if (input_date < lubridate::today()  && mago == 0) {
      input_date <- input_date %m+% months(interval_amount)
      input_date <- find_day(input_date, as.numeric(pub_week), pub_day)
    }
  }  
  return(input_date)
}

# ADDITIONAL FUNCTIONS -----------------

set_interval <- function(frequency){
  #convert the word to it's unit of measurement
  if (frequency == "quarterly"){
      interval_amount <- 3
    } else if (frequency == "annually"){
      interval_amount <- 12
    } else if (frequency == "monthly"){
      interval_amount <- 1
    } else if (frequency == "biennially"){
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
  input_date <- lubridate::make_date(year(input_date), month(input_date), 01)
  next_quarter <- ceiling( (lubridate::month(input_date) - first_pub) / 3) * 3 + first_pub
  increase_mon <- next_quarter - lubridate::month(input_date)
  input_date <- input_date %m+% months(increase_mon)
  return(input_date)
}

get_annual <- function(input_date, first_pub){
  #for annual pubs establishes date in correct month
  input_date <- make_date(year(input_date), first_pub, 01)
  return(input_date)
}

get_biennial <- function(input_date, first_pub, bi_start){
  #for biennial pubs establishes date in correct month and year
  input_year <- lubridate::year(input_date)
  if (bi_start == "even") {
    new_year <- input_year + input_year %% 2
  }
  else if (bi_start == "odd") {
    new_year <- input_year + (input_year %% 2 + 1) %% 2
  }
  new_date <- make_date(new_year, first_pub, 01)
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