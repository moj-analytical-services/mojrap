#' Create a ggplot2 scale function for an mojchart palette
#'
#' Generates a discrete scale function for an mojchart palette and a given
#' aesthetic, using `ggplot2::scale_discrete_manual()`. This function originates
#' from the mojchart package, see
#' \url{https://github.com/moj-analytical-services/mojchart}.
#'
#' @inheritParams scales
#' @param aesthetics The aesthetic(s) that the scale work with. Passed to the
#'   `aesthetics` parameter of `ggplot2::scale_discrete_manual()`.
#' @return Returns a ggplot2 scale function.
#' @family mojchart functions
#' @noRd
#' @examples
#' library(ggplot2)
#' create_moj_scale(5, scheme = "vibrant1", aesthetics = "colour")
create_moj_scale <- function(n, scheme, order = NULL, aesthetics, ...){

  # Set default order
  if (is.null(order))
    order <- 1:n

  pal <- mojchart_palette(n, scheme)

  pal_reorder <- reorder_palette(pal, order)

  ggplot2::scale_discrete_manual(aesthetics, values = unname(pal_reorder), ...)
}

#' ggplot2 scale functions
#'
#' These functions add a colour palette to a ggplot2 chart. They originate
#' from the mojchart package. For an overview and examples, see
#' \url{https://github.com/moj-analytical-services/mojchart}.
#'
#' @param n The number of colours required, from one to six.
#' @param scheme The name of a colour scheme. Run `scheme_names()` for the
#'   available options. "Muted" schemes are generally recommended for the fill
#'   scale and "vibrant" schemes for the colour scale.
#' @param order A numeric vector giving the order in which to apply the colours.
#'   `order` must have length `n`. Numbers can be repeated to apply the same
#'   colour to multiple categories in the data.
#' @param ... Other arguments passed to scale_discrete_manual().
#' @return Returns a ggplot2 scale function.
#' @name scales
#' @family mojchart functions
#' @examples
#' library(dplyr)
#' library(ggplot2)
#' txhousing %>%
#'   filter(city %in% c("Abilene", "Bay Area", "Collin County")) %>%
#'   ggplot(aes(x = date, y = sales, group = city, colour = city)) +
#'   geom_line(size = 1.5) +
#'   scale_colour_moj(3, scheme = "vibrant1")
#'
#' mpg %>%
#'   ggplot(aes(x = factor(year), y = displ, fill = factor(cyl))) +
#'   geom_col(position = "dodge") +
#'   theme_gss() +
#'   scale_fill_moj(4, scheme = "muted1")
NULL

#' @rdname scales
#' @export
scale_colour_moj <- function(n, scheme = "vibrant1", order = NULL, ...){
  create_moj_scale(n, scheme, order, aesthetics = "colour", ...)
}

#' @rdname scales
#' @export
scale_fill_moj <- function(n, scheme = "muted1", order = NULL, ...){
  create_moj_scale(n, scheme, order, aesthetics = "fill", ...)
}
