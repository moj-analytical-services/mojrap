#' GSS style theme
#'
#' A theme based on Government Statistical Service (GSS) guidance:
#' \url{https://gss.civilservice.gov.uk/policy-store/introduction-to-data-visualisation/}.\cr
#' This function originates from the mojchart package. For an overview and
#' examples of suggested usage, see
#' \url{https://github.com/moj-analytical-services/mojchart}.
#'
#' @param base_size The base font size for chart text. For publication charts on
#'   gov.uk you probably need around size 20. For details of what this parameter
#'   does, see \url{https://ggplot2-book.org/polishing.html}.
#' @param base_line_size The base size for lines controlled by the theme
#'   function (i.e. non-data lines).
#' @param flipped A logical value indicating whether the chart has flipped axes.
#' @param xticks A logical value indicating whether to add tick marks to the x
#'   axis. Only adds ticks if `flipped = FALSE`.
#' @param xlabel A logical value indicating whether to show the x axis label.
#' @importFrom ggplot2 theme
#' @importFrom ggplot2 element_text
#' @importFrom ggplot2 element_line
#' @importFrom ggplot2 element_blank
#' @importFrom ggplot2 margin
#' @importFrom ggplot2 unit
#' @importFrom ggplot2 theme_grey
#' @importFrom ggplot2 ggplot
#' @return Returns a ggplot2 theme function.
#' @family mojchart functions
#' @export
#' @examples
#' library(dplyr)
#' library(ggplot2)
#' txhousing %>%
#'   filter(city %in% c("Abilene", "Bay Area", "Collin County")) %>%
#'   ggplot(aes(x = date, y = sales, group = city, colour = city)) +
#'   labs(title = "Housing sales in Texas",
#'        subtitle = "2000 to 2015\n\nNumber of sales",
#'        caption = "Source: txhousing dataset, ggplot2") +
#'   expand_limits(y = 2000) +
#'   geom_line(size = 1.5) +
#'   theme_gss()
theme_gss <- function(base_size = 20, base_line_size = 0.5, flipped = FALSE, xticks = FALSE, xlabel = FALSE){

  # Base theme object
  base_elements <- theme_grey(base_size = base_size, base_line_size = base_line_size) +
    theme(line = element_line(colour = "grey80"),
          panel.grid = element_blank(),
          axis.ticks = element_blank(),
          axis.ticks.length = unit(0.5, "lines"),
          axis.title = element_blank(),
          panel.background = element_blank(),
          legend.title = element_blank(),
          legend.key = element_blank(),
          legend.key.size = unit(2, "lines"),
          plot.title = element_text(face = "bold"),
          plot.subtitle = element_text(margin = margin(b = 10)),
          plot.caption = element_text(hjust = 0, margin = margin(t = 10)),
          plot.title.position = "plot",
          plot.caption.position = "plot"
    )

  # To add for regular orientation
  regular_elements <- theme(
    panel.grid.major.y = element_line(),
    axis.line.x = element_line()
  )

  # To add for flipped orientation
  flipped_elements <- theme(
    panel.grid.major.x = element_line(),
    axis.line.y = element_line(),
    axis.title = element_blank(),
    axis.text.y = element_text(margin = margin(r = 10))
  )

  # To add x axis ticks
  xticks_element <- theme(
    axis.ticks.x = element_line()
  )

  # To add x axis label
  xlabel_element <- theme(
    axis.title.x = element_text(margin = margin(t = 10))
  )

  # Build final theme
  if (!flipped) {
    t <- base_elements +
      regular_elements
  } else {
    t <- base_elements +
      flipped_elements
  }

  if (!flipped && xticks)
    t <- t +
      xticks_element

  if (xlabel)
    t <- t +
      xlabel_element

  t
}
