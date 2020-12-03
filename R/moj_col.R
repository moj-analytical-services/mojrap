#' Choosing a colour, its number of data classes and shade
#'
#' @description You can choose between 6 different colours and their shades. This function can be useful for adding colour to your charts.
#'
#' @param colour Choices of 6 different colours: blue, green, grey, orange, purple and red.
#' @param x Shade of colour, in order from brightest to darkest.
#' @param class Number of data classes (different shades) of the chosen colour. The default number of classes is 9. The number of data classes can only be between 3 and 9
#
#' @examples
#' moj_col("blue", 2) gives you colour #deebf7, which is the 2nd brightest of the 9 shades of blue.
#' moj_col("blue", x = c(5, 7), class = 7) gives you colours #4292c6 and #084594. These are the 5th and last of the 7 shades of blue.
#' moj_col("orange", class = 5) gives you all 5 shades of orange.
#' c(moj_col("red", x = 5:8), moj_col("purple", x = 6:7, class = 8)) gives you red colours (#fb6a4a, #ef3b2c, #cb181d and #a50f15) and purple colours (#807dba and #6a51a3)
#'
#' @return Colour(s)
#'
#' @export

moj_col <- function(colour, x, class = 9) {

  if (!data.table::inrange(class, 3, 9, incbounds = TRUE)){
    stop("The number of data classes can only be between 3 and 9")}

  else if (is.element(colour, c("blue", "green", "grey", "orange", "purple", "red")) != TRUE){
    stop("The only colours you can select are: blue, green, grey, orange, purple and red")}

  else if (any(x > class) == TRUE){
    stop("The shade of colour must be a smaller number than the number of data classes")}

  else{

    # Selects chosen colour and number of data classes
    output <- mojrap::col_series(colour, class)

    # Selects chosen shade of colour
    output <- output[x]

    return(output)}

}
