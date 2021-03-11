#' Colour palettes
#'
#' Returns a named list of colour schemes, each containing six palettes, for one
#' to six data categories. This function originates from the mojchart package,
#' see \url{https://github.com/moj-analytical-services/mojchart}. The
#' "stats2017" scheme is from the 2017 statistical bulletin guidance. It should
#' be used with caution for more than three categories, as the palettes with
#' four, five or six colours contain colours that are likely to be
#' indistinguishable for individuals with common forms of colour blindness.
#'
#' @family mojchart functions
#' @noRd
#' @examples
#' palettes()
palettes <- function(){
  palettes <- list(
    muted1 = list(
      palette_colours("mojblue"),
      palette_colours("mojblue", "lightblue1"),
      palette_colours("mojblue", "lightblue1", "paleblue1"),
      palette_colours("mojdarkblue", "midblue1", "lightblue1", "paleblue1"),
      palette_colours("mojdarkblue", "midblue1", "teal2", "lightblue1", "paleblue1"),
      palette_colours("mojdarkblue", "midblue1", "teal2", "lightblue1", "yellow1", "paleblue1")
    ),
    muted2 = list(
      palette_colours("mojblue"),
      palette_colours("mojblue", "lightblue1"),
      palette_colours("mojblue", "teal1", "yellow1"),
      palette_colours("mojdarkblue", "midblue1", "teal1", "yellow1"),
      palette_colours("mojdarkblue", "midblue1", "teal2", "lightblue1", "yellow1"),
      palette_colours("mojdarkblue", "midblue1", "teal2", "lightblue1", "yellow1", "paleblue1")
    ),
    muted3 = list(
      palette_colours("mojblue"),
      palette_colours("mojblue", "yellow2"),
      palette_colours("mojblue", "teal2", "yellow2"),
      palette_colours("mojblue", "teal2", "pink1", "yellow1"),
      palette_colours("mojdarkblue", "midblue1", "teal2", "pink1", "yellow1"),
      palette_colours("mojdarkblue", "midblue1", "teal2", "lightblue1", "pink1", "yellow1")
    ),
    vibrant1 = list(
      palette_colours("mojblue"),
      palette_colours("mojblue", "mojbrightblue"),
      palette_colours("mojblue", "mojbrightblue", "mojgrey"),
      palette_colours("mojblue", "mojbrightblue", "mojgrey", "mojbrightorange"),
      palette_colours("mojblue", "mojbrightblue", "mojgrey", "mojbrightorange", "mojgreen"),
      palette_colours("mojblue", "mojbrightblue", "mojgrey", "mojbrightorange", "mojgreen", "mojpink")
    ),
    vibrant2 = list(
      palette_colours("mojblue"),
      palette_colours("mojblue", "mojbrightblue"),
      palette_colours("mojblue", "mojbrightblue", "mojbrightorange"),
      palette_colours("mojblue", "mojbrightblue", "mojbrightorange", "mojgreen"),
      palette_colours("mojblue", "mojbrightblue", "mojbrightorange", "mojgreen", "mojpink"),
      palette_colours("mojblue", "mojbrightblue", "mojbrightorange", "mojgreen", "mojpink", "mojgrey")
    ),
    stats2017 = list(
      palette_colours("stats1"),
      palette_colours("stats1", "stats2"),
      palette_colours("stats1", "stats2", "stats3"),
      palette_colours("stats1", "stats2", "stats3", "stats4"),
      palette_colours("stats1", "stats2", "stats3", "stats4", "stats5"),
      palette_colours("stats1", "stats2", "stats3", "stats4", "stats5", "stats6")
    )
  )
}

#' Colour scheme names
#'
#' Returns the names of the available colour schemes. This function originates from
#' the mojchart package, see
#' \url{https://github.com/moj-analytical-services/mojchart}.
#'
#' @family mojchart functions
#' @export
scheme_names <- function(){
  names(palettes())
}

#' Single colour palette
#'
#' Returns a single colour palette as a named character vector. This function
#' originates from the mojchart package, see
#' \url{https://github.com/moj-analytical-services/mojchart}.
#'
#' @param n The required number of colours in the palette, from one to six.
#' @param scheme The name of a colour scheme as a character string. Run
#'   `scheme_names()` for the available options.
#' @family mojchart functions
#' @export
#' @examples
#' mojchart_palette(5, scheme = "vibrant1")
mojchart_palette <- function(n, scheme){

  # Check n is an integer
  if (n != as.integer(n))
    stop("n must be an integer.", call. = FALSE)

  # Check n is within range
  if (n < 1 | n > 6){
    stop("n must be between 1 and 6.", call. = FALSE)
  }

  # Check scheme name is valid
  if (!scheme %in% names(palettes())){
    scheme_names_as_string <- paste(scheme_names(), collapse = '", "')
    message <- glue::glue('"{scheme}" is not a valid scheme name. The available schemes are: "{scheme_names_as_string}".')
    rlang::abort(message = message)
  }

  # Warning for palettes with poor colour blindness accessibility
  if (n %in% c(4, 5, 6) && scheme == "stats2017"){
    rlang::warn("This colour palette is likely to be inaccessible to some colour-blind users. If you use it, please
ensure you are not relying on colour alone to distinguish categories in your data. To assess the
accessibility of your chart, see for example https://www.color-blindness.com/coblis-color-blindness-simulator/."
    )
  }

  palettes()[[scheme]][[n]]
}

#' Reorder a palette
#'
#' Rearranges the elements of a vector. Intended for reordering a palette.
#'
#' @param x A vector to be reordered.
#' @param order A numeric vector containing the desired order. Must be the same
#'   length as `x` and can only contain numbers that correspond to elements of
#'   `x`. Numbers can be repeated, which when applied to a chart will give the
#'   same colour to multiple categories in the data. This function originates
#'   from the mojchart package, see
#'   \url{https://github.com/moj-analytical-services/mojchart}.
#' @return Returns the reordered vector.
#' @family mojchart functions
#' @noRd
#' @examples
#' pal <- c("#1d609d", "#00b1eb", "#003057")
#' reorder_palette(pal, order = c(2, 1, 3))
#' reorder_palette(pal, order = c(1, 2, 2))
reorder_palette <- function(x, order){

  # Check order vector is the correct length.
  if (length(x) != length(order))
    stop("Palette and order vector have different lengths.")

  allowed_values <- 1:length(x)

  # Check all elements of order are within range.
  for (value in order){
    if (!value %in% allowed_values){
      message <- glue::glue("`order` cannot contain {value} for a palette of length {length(x)}.")
      rlang::abort(message = message)
    }
  }

  x[order]
}
