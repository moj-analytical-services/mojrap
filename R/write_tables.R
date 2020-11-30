#' @param wb openxlsx workbook object
#' @param sheet string. Sheet name in the wb object
#' @param rows numeric vector. Row numbers in the wb object that you want to apply the merge formatting to
#' @param cols numeric vector. Column numbers in the wb object that you want to merge together.
#' @name multiple_cell_merge
#' @title Merges multiple columns of cells in an Excel sheet, by row

multiple_cell_merge <- function(wb, sheet, rows, cols) {
  for(i in rows)
    openxlsx::mergeCells(wb = wb,
                         sheet = sheet,
                         cols = cols,
                         i)
}


#' @param workbook openxlsx workbook object
#' @param sheet_name string. Sheet name in the wb object
#' @param tables a list of data.frame objects to write to the sheet.
#' @param notes a character vector of notes to write to the sheet
#' @param starting_row numeric. Row number on the sheet you would like to start writing the tables at.
#' @param quarterly_format numeric vector. List position of the tables in the tables list to apply quarterly formatting to. Default is NULL.
#' @export
#' @name save_formatted_table
#' @title Writes multiple data tables and accompanying notes to an Excel sheet, with formatting.
save_formatted_table <- function(workbook, sheet_name, tables, notes, starting_row, quarterly_format = NULL) {

  #Throw error if not passed a list of tables
  if(inherits(tables, "list") == FALSE) {stop("Tables must be provided as a list")}
  #Throw error if not passed a vector of notes
  if(is.vector(notes) == FALSE | inherits(notes, "list") == TRUE) {stop("Notes must be provided as a vector")}

  ##Set starting row parameters
  start_row <- starting_row

  ##Vectorise this across all tables
  for(i in seq_len(length(tables))) {
    #Set location of end row based on number of rows in a table
    if(is.data.frame(tables[[i]])) {
      end_row <- start_row + nrow(tables[[i]]) - 1
    } else {
  #If it's not a data frame, just write it to a single line
      end_row <- start_row
    }

    #Write data into place
    openxlsx::writeData(wb = workbook,
                        sheet = sheet_name,
                        x = tables[[i]],
                        startRow = start_row,
                        colNames = F)

    ##Add line at end of data (but only if data is a data frame)
    if(is.data.frame(tables[[i]])) {
      openxlsx::addStyle(workbook,
                         sheet_name,
                         style = openxlsx::createStyle(
                           border = "bottom",
                           borderStyle = "thin"),
                         rows = end_row,
                         cols = seq_len(ncol(tables[[i]])),
                         stack = T,
                         gridExpand = T)
    } else{

      #If the provided data is not a data frame, just make it bold (used to differentiate headers)
      openxlsx::addStyle(workbook,
                         sheet_name,
                         openxlsx::createStyle(textDecoration = "bold"),
                         rows = start_row,
                         cols = 1,
                         stack = T,
                         gridExpand = T)
    }

    ##Set row heights for quarterly tables; every 4th row is taller to break up data
    #only for tables specified in quarterly_format argument
    if(i %in% quarterly_format) {
      quarterly_rows <- seq(from = start_row, to = end_row, by = 4)
      openxlsx::setRowHeights(wb = workbook,
                    sheet = sheet_name,
                    rows = quarterly_rows,
                    heights = 26.25)
      #Make sure all values are aligned to the bottom of the cell
      openxlsx::addStyle(workbook,
                         sheet_name,
                         openxlsx::createStyle(valign = "bottom"),
                         rows = start_row:end_row,
                         cols = seq_len(ncol(tables[[i]])),
                         stack = T,
                         gridExpand = T)
    }

    #Create new start row value, 2 rows below previous table
    start_row <- end_row + 2
  }

  ##Write notes to sheet below last table
  start_row_notes <- end_row + 2
  end_row_notes <- start_row_notes + length(notes)
  openxlsx::writeData(wb = workbook,
                      sheet = sheet_name,
                      x = notes,
                      startRow = start_row_notes,
                      colNames = F)

  ##Create style for notes; small font size, left and top aligned
  note_style <- openxlsx::createStyle(
    fontName = "Arial",
    fontSize = "8",
    halign = "left",
    valign = "top",
    wrapText = TRUE
  )
  #Format notes; merge and then add style
  multiple_cell_merge(wb = workbook,
                      sheet = sheet_name,
                      rows = start_row_notes:end_row_notes,
                      cols = seq_len(ncol(tables[[1]])))
  openxlsx::addStyle(wb = workbook,
                     sheet = sheet_name,
                     style = note_style,
                     rows = start_row_notes:end_row_notes,
                     cols = seq_len(ncol(tables[[1]])),
                     stack = T,
                     gridExpand = T)

  #Remove gridlines from sheet
  openxlsx::showGridLines(wb = workbook,
                          sheet = sheet_name,
                          showGridLines = FALSE)
}
