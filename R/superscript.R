#' Add superscipts/subscripts to Excel files
#'
#' Writes text to a cell within a wookbook object and adds a superscript or a subscript.
#'
#' @param wb A workbook object
#' @param sheet A sheet within the workbook object
#' @param row The row number you want to write to
#' @param col The column number you want to write to
#' @param text The text (not including the superscript) you want written.
#' @param superScriptText The text you want in the superscript
#' @param position A number specifying how far along in the text you want the superscript to occur. Defaults to nchar(text), (ie, the last position)
#' @param superOrSub TRUE or FALSE is you want to return a superscript or a subscript. Defaults to superscript (TRUE)
#' @param size The size of the font. Defaults to 10
#' @param colour The hex code of the colour of the text. Defaults to black (000000)
#' @param font The font. Defaults to Arial
#' @param family Not sure what this is for. Leave it alone at 2 if you don't know either
#' @param bold TRUE or FALSE if you want text to be bold
#' @param italic TRUE or FALSE if you want text to be italic
#' @param underlined TRUE or FALSE if you want text to be underlined
#'
#' @examples
#' \dontrun{
#' addSuperScriptToCell(wb = wb,
#'  sheet = "2.1",
#'  row = 1,
#'  col =1,
#'  text = "Table 2.1: First prison receptions by type of first reception, sentence length and sex",
#'  superScriptText = "(1)",
#'  position = 34,
#'  superOrSub = TRUE,
#'  size = '12',
#'  colour = '000000',
#'  font = 'Arial',
#'  family = '2',
#'  bold = TRUE,
#'  italic = FALSE,
#'  underlined = FALSE)
#' }
#'
#' @export


addSuperScriptToCell <- function(wb,
                                 sheet,
                                 row,
                                 col,
                                 text,
                                 superScriptText,
                                 position = nchar(text),
                                 superOrSub = TRUE,
                                 size = '10',
                                 colour = '000000',
                                 font = 'Arial',
                                 family = '2',
                                 bold = FALSE,
                                 italic = FALSE,
                                 underlined = FALSE){


  # MAIN BODY----------------------------------------------------------------------------------------

  placeholderText <- 'This is placeholder text that should not appear anywhere in your document.'

  openxlsx::writeData(wb = wb,
                      sheet = sheet,
                      x = placeholderText,
                      startRow = row,
                      startCol = col)

  #finds the string that you want to update
  stringToUpdate <- which(sapply(wb$sharedStrings,
                                 function(x){
                                   grep(pattern = placeholderText,
                                        x)
                                 }
  )
  == 1)

  #splits the text into before and after the superscript

  preText <- stringr::str_sub(text,
                              1,
                              position)

  postText <- stringr::str_sub(text,
                               position + 1,
                               nchar(text))

  #formatting instructions

  sz    <- paste('<sz val =\"',size,'\"/>',
                 sep = '')
  col   <- paste('<color rgb =\"',colour,'\"/>',
                 sep = '')
  rFont <- paste('<rFont val =\"',font,'\"/>',
                 sep = '')
  fam   <- paste('<family val =\"',family,'\"/>',
                 sep = '')
  if(superOrSub){
    vert <- '<vertAlign val=\"superscript\"/>'
  } else{vert <- '<vertAlign val=\"subscript\"/>'}

  if(bold){
    bld <- '<b/>'
  } else{bld <- ''}

  if(italic){
    itl <- '<i/>'
  } else{itl <- ''}

  if(underlined){
    uld <- '<u/>'
  } else{uld <- ''}

  #run properties

  rPrText <- paste(sz,
                   col,
                   rFont,
                   fam,
                   bld,
                   itl,
                   uld,
                   sep = '')

  rPrSuperText <- paste(vert,
                        sz,
                        col,
                        rFont,
                        fam,
                        bld,
                        itl,
                        uld,
                        sep = '')

  newString <- paste('<si><r><rPr>',
                     rPrText,
                     '</rPr><t xml:space="preserve">',
                     preText,
                     '</t></r><r><rPr>',
                     rPrSuperText,
                     '</rPr><t xml:space="preserve">',
                     superScriptText,
                     '</t></r><r><rPr>',
                     rPrText,
                     '</rPr><t xml:space="preserve">',
                     postText,
                     '</t></r></si>',
                     sep = '')

  wb$sharedStrings[stringToUpdate] <- newString
}
