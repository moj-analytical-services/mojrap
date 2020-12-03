#' Choosing a colour and its number of shades
#'
#' @description You can choose between 6 different colours and how many different shades.
#'
#' @param colour Choices of 6 different colours: blue, green, grey, orange, purple and red.
#' @param class Number of data classes (different shades) of the chosen colour. The number of data classes can only be between 3 and 9.
#
#' @examples
#' col_series("blue", 5) gives you 5 different shades of blue
#' col_series("purple", 8) gives you 8 different shades of purple
#'
#' @return Different shades of chosen colour
#'
#' @export

col_series <- function(colour, class) {

  if (colour %in% c('blue', 'green', 'grey', 'orange', 'purple', 'red') == FALSE) {
    stop("The 'colour' argument must be one of six strings: 'blue', 'green', 'grey', 'orange', 'purple' or 'red'")
  }

  if (class %in% c(3,4,5,6,7,8,9) == FALSE) {
    stop("The 'class' argument must be a number between 3 and 9 inclusive")
  }


  if ( (data.table::inrange(class, 3, 9, incbounds = TRUE)
        && is.element(colour, c("blue", "green", "grey", "orange", "purple", "red") ) == TRUE)){

    # Creating a vector of each colour. Each of those vectors has all shades for all numbers of data classes (series)

    blue <- c('#deebf7' ,'#9ecae1' ,'#3182bd' ,'#eff3ff' ,'#bdd7e7' ,'#6baed6' ,'#2171b5' ,'#eff3ff' ,'#bdd7e7' ,'#6baed6' ,'#3182bd' ,'#08519c' ,'#eff3ff' ,'#c6dbef' ,'#9ecae1' ,'#6baed6' ,'#3182bd' ,'#08519c' ,'#eff3ff' ,'#c6dbef' ,'#9ecae1' ,'#6baed6' ,'#4292c6' ,'#2171b5' ,'#084594' ,'#f7fbff' ,'#deebf7' ,'#c6dbef' ,'#9ecae1' ,'#6baed6' ,'#4292c6' ,'#2171b5' ,'#084594' ,'#f7fbff' ,'#deebf7' ,'#c6dbef' ,'#9ecae1' ,'#6baed6' ,'#4292c6' ,'#2171b5' ,'#08519c' ,'#08306b'
    )

    green <- c('#e5f5e0' ,'#a1d99b' ,'#31a354' ,'#edf8e9' ,'#bae4b3' ,'#74c476' ,'#238b45' ,'#edf8e9' ,'#bae4b3' ,'#74c476' ,'#31a354' ,'#006d2c' ,'#edf8e9' ,'#c7e9c0' ,'#a1d99b' ,'#74c476' ,'#31a354' ,'#006d2c' ,'#edf8e9' ,'#c7e9c0' ,'#a1d99b' ,'#74c476' ,'#41ab5d' ,'#238b45' ,'#005a32' ,'#f7fcf5' ,'#e5f5e0' ,'#c7e9c0' ,'#a1d99b' ,'#74c476' ,'#41ab5d' ,'#238b45' ,'#005a32' ,'#f7fcf5' ,'#e5f5e0' ,'#c7e9c0' ,'#a1d99b' ,'#74c476' ,'#41ab5d' ,'#238b45' ,'#006d2c' ,'#00441b'
    )

    grey <- c('#f0f0f0' ,'#bdbdbd' ,'#636363' ,'#f7f7f7' ,'#cccccc' ,'#969696' ,'#525252' ,'#f7f7f7' ,'#cccccc' ,'#969696' ,'#636363' ,'#252525' ,'#f7f7f7' ,'#d9d9d9' ,'#bdbdbd' ,'#969696' ,'#636363' ,'#252525' ,'#f7f7f7' ,'#d9d9d9' ,'#bdbdbd' ,'#969696' ,'#737373' ,'#525252' ,'#252525' ,'#ffffff' ,'#f0f0f0' ,'#d9d9d9' ,'#bdbdbd' ,'#969696' ,'#737373' ,'#525252' ,'#252525' ,'#ffffff' ,'#f0f0f0' ,'#d9d9d9' ,'#bdbdbd' ,'#969696' ,'#737373' ,'#525252' ,'#252525' ,'#000000'
    )

    orange <- c('#fee6ce' ,'#fdae6b' ,'#e6550d' ,'#feedde' ,'#fdbe85' ,'#fd8d3c' ,'#d94701' ,'#feedde' ,'#fdbe85' ,'#fd8d3c' ,'#e6550d' ,'#a63603' ,'#feedde' ,'#fdd0a2' ,'#fdae6b' ,'#fd8d3c' ,'#e6550d' ,'#a63603' ,'#feedde' ,'#fdd0a2' ,'#fdae6b' ,'#fd8d3c' ,'#f16913' ,'#d94801' ,'#8c2d04' ,'#fff5eb' ,'#fee6ce' ,'#fdd0a2' ,'#fdae6b' ,'#fd8d3c' ,'#f16913' ,'#d94801' ,'#8c2d04' ,'#fff5eb' ,'#fee6ce' ,'#fdd0a2' ,'#fdae6b' ,'#fd8d3c' ,'#f16913' ,'#d94801' ,'#a63603' ,'#7f2704'
    )

    purple <- c('#efedf5' ,'#bcbddc' ,'#756bb1' ,'#f2f0f7' ,'#cbc9e2' ,'#9e9ac8' ,'#6a51a3' ,'#f2f0f7' ,'#cbc9e2' ,'#9e9ac8' ,'#756bb1' ,'#54278f' ,'#f2f0f7' ,'#dadaeb' ,'#bcbddc' ,'#9e9ac8' ,'#756bb1' ,'#54278f' ,'#f2f0f7' ,'#dadaeb' ,'#bcbddc' ,'#9e9ac8' ,'#807dba' ,'#6a51a3' ,'#4a1486' ,'#fcfbfd' ,'#efedf5' ,'#dadaeb' ,'#bcbddc' ,'#9e9ac8' ,'#807dba' ,'#6a51a3' ,'#4a1486' ,'#fcfbfd' ,'#efedf5' ,'#dadaeb' ,'#bcbddc' ,'#9e9ac8' ,'#807dba' ,'#6a51a3' ,'#54278f' ,'#3f007d'
    )

    red <- c('#fee0d2' ,'#fc9272' ,'#de2d26' ,'#fee5d9' ,'#fcae91' ,'#fb6a4a' ,'#cb181d' ,'#fee5d9' ,'#fcae91' ,'#fb6a4a' ,'#de2d26' ,'#a50f15' ,'#fee5d9' ,'#fcbba1' ,'#fc9272' ,'#fb6a4a' ,'#de2d26' ,'#a50f15' ,'#fee5d9' ,'#fcbba1' ,'#fc9272' ,'#fb6a4a' ,'#ef3b2c' ,'#cb181d' ,'#99000d' ,'#fff5f0' ,'#fee0d2' ,'#fcbba1' ,'#fc9272' ,'#fb6a4a' ,'#ef3b2c' ,'#cb181d' ,'#99000d' ,'#fff5f0' ,'#fee0d2' ,'#fcbba1' ,'#fc9272' ,'#fb6a4a' ,'#ef3b2c' ,'#cb181d' ,'#a50f15' ,'#67000d'
    )

    # Categorising each shade of colour to which series (number of data classes) it belongs to
    series <- c(rep(3,3), rep(4,4), rep(5,5), rep(6,6), rep(7,7), rep(8,8), rep(9,9))

    # Creating a data frame that puts together all shades of colours from different series
    palette <- data.frame(blue, green, grey, orange, purple, red, series)
    rm(blue, green, grey, orange, purple, red, series)

    # Selecting the colour, filtered to chosen series
    output <- dplyr::select(dplyr::filter(palette, series == class), dplyr::all_of(colour))
    rm(palette)

    output <- as.vector(output[,1])

    return(output)}

}
