library(lubridate)

# pub_date
#
#' Takes the publication name and returns the next publication date
#
#' This will take the name and the date and find the next publication date on a thursday.  
#' It does a check to make to make sure that it is not a past date unless manual overwritten.
#' @param pub_name input the publication shorthand name
#' @param mago Reduce the date by this many months
#' @param qago Reduce the date by this many quarters
#' @param yago Reduce the date by this many years
#' @param manual_date Add the starting date.  If blank, the current date (i.e, today()) will be use

#' @examples
#' Need to set examples here
#'
#' @export

pub_date <- function(pub_name = 0, mago = 0, qago = 0, yago = 0, manual_date = 0) {
  publication <- create_data(pub_name)
  input_date <- mpub_date(manual_date)
  input_date <- backdate_date(input_date, qago, yago, mago)
  interval_amount <- set_interval(publication["frequency"])
  if (interval_amount == 3) {
    input_date <- get_quarter(input_date, as.numeric(publication["firstpub"]))
  } else if (interval_amount == 12) {
    input_date <- get_annual(input_date, as.numeric(publication["pub_month"]))
  } else {
    input_date <- get_biennial(input_date, as.numeric(publication["pub_month"]), publication["bi_start"])
  }
  input_date <- find_thurs(input_date, as.numeric(publication["pub_thurs"]))
  #I can only see it being a past date if in the same month.  Therefore this reruns under that
  if (input_date < today()  && mago + qago + yago + manual_date == 0) {
    input_date <- input_date %m+% months(interval_amount)
    input_date <- find_thurs(input_date, as.numeric(publication["pub_thurs"]))
  }
  return(input_date)
}

create_data <- function (pub_name) {
  var_names <- c("pub_name", "pub_full_name", "pub_thurs", "frequency", "calendar",
                 "pub_month", "firstpub", "delay", "bi_start")

  CAFS1 <- c("CAFS1", "Civil Justice", 1, "quarterly", TRUE, 0, 3, 6, NA)
  CAFS2 <- c("CAFS2", "Coroner", 2, "annually", TRUE, 5, 0, 0, NA)
  CAFS3 <- c("CAFS3", "Family Court", 5, "quarterly", TRUE, 0, 3, 6, NA)
  CAFS4 <- c("CAFS4", "Judicial Appointment Commision", 1, "annually", TRUE, 6, 0, 0, NA)
  CAFS5 <- c("CAFS5", "Judicial Diversity", 2, "annually", TRUE, 7, 2, 0, NA)
  CAFS6 <- c("CAFS6", "Mortgages and Landlord Possession", 2, "quarterly", TRUE, 0, 2, 5, NA)
  CAFS7 <- c("CAFS7", "Tribunals and Gender Recognition", 2, "quarterly", FALSE, 0, 3, 6, NA)
  CJSS1 <- c("CJSS1", "Criminal Courts", 5, "quarterly", TRUE, 0, 3, 6, NA)
  CJSS2 <- c("CJSS2", "Criminal Justice System", 3, "quarterly", TRUE, 0, 2, 8, NA)
  DIAL1 <- c("DIAL1", "Justice Data Lab", 2, "quarterly", TRUE, 0, 1, 4, NA)
  DIAL2 <- c("DIAL2", "Knife & Offensice Weapon Sentencing", 2, "quarterly", TRUE, 0, 3, 6, NA)
  LAPD1 <- c("LAPD1", "Legal Aid", 5, "quarterly", FALSE, 0, 3, 6, NA)
  PPRS1 <- c("PPRS1", "Offender Management", 4, "quarterly", TRUE, 0, 1, 10, NA)
  PPRS2 <- c("PPRS2", "Proven Reoffending", 4, "quarterly", TRUE, 0, 1, 25, NA)
  PPRS3 <- c("PPRS3", "Payment By Results", 4, "quarterly", TRUE, 0, 1, 25, NA)
  WCJS <- c("WCJS", "Women and the Criminal Justice System", 5, "biennial", TRUE, 11, 0, 0, "odd")
  RCJS <- c("RCJS", "Race and the Criminal Justice System", 5, "biennial", TRUE, 11, 0, 0, "even")
  publication <- eval(as.name(pub_name))
  names(publication) <- var_names

  return(publication)
}

set_interval <- function(frequency){
  #convert the word to it's unit of measurement
  if (frequency == "quarterly"){
      interval_amount <- 3
    } else if (frequency == "annually"){
      interval_amount <- 12
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

backdate_date <- function (input_date, qago, yago, mago){
  months_ago <- (3 * qago) + (12 * yago) + (mago)
  new_date <- input_date %m-% months(months_ago)
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

get_biennial <- function(input_date, pub_month, even){
  input_year <- year(input_date)
  if (even == TRUE) {
    new_year <- input_year + input_year %% 2
  }
  else {
    new_year <- input_year + (input_year %% 2 + 1) %% 2
  }
  new_date <- make_date(new_year, pub_month, day(input_date))
  return(new_date)
}

find_thurs <- function(input_date, pub_thurs){
  month_list <- seq(
    floor_date(input_date, "month"),
    ceiling_date(input_date, "month") - 1,
    by = "1 day")
  thurs_list <- month_list[wday(month_list, label = TRUE) == "Thu"]
  pub_thurs <- min(length(thurs_list), pub_thurs)
  new_pub_date <- thurs_list[pub_thurs]
  return(new_pub_date)
}

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