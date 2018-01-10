# getThursday
#
#' Takes the current year and quarter and predicts the next thursday that a quarterly publication will be published on.
#
#' @param y current year
#' @param q current quarter

#' @examples
#' getThursday(2017, "q3")  # returns "2018-01-25"
#'
#' @export

getThursday = function(y, q) {

  q <- gsub("[^0-9\\.]", "", q)

  y <- as.numeric(y)
  q <- as.numeric(q)

  if (q >= 2) {y <- y + 1}
  if (q == 4) {q <- 0}

  date = lubridate::ymd(paste(y,"-",c("07","10","01","04")[q + 1],"-01",sep=""))
  last = lubridate::ceiling_date(date,"month") - 1
  dow = sapply(seq(0,6),function(y) lubridate::wday(last - lubridate::days(y)))
  lastThursday = last - lubridate::days(which(dow==5)-1)
  return(as.character(lastThursday))
}

