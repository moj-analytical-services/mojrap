##Create workbook object with sheets
wb <- openxlsx::createWorkbook()
openxlsx::addWorksheet(wb, sheetName = "sheet1")

save_formatted_table(workbook = wb,
                     sheet_name = "sheet1",
                     tables = list(mtcars[1:3, 1:3], "Cars", mtcars[4:6, 1:5]),
                     notes = c("a", "b"),
                     starting_row = 3,
                     quarterly_format = NULL)

#Save to temporary file
tmp_file <- tempfile(fileext = ".xlsx")
saveWorkbook(wb = wb, file = tmp_file, overwrite = TRUE)


test_that("Tables write in the expected position on a sheet", {

  #Check values expected at various points in the sheet
  expect_equal(read.xlsx(tmp_file, colNames = FALSE, skipEmptyRows = FALSE)[1,1], "21")
  expect_equal(read.xlsx(tmp_file, colNames = FALSE, skipEmptyRows = FALSE)[7,4], 110)
  expect_equal(read.xlsx(tmp_file, colNames = FALSE, skipEmptyRows = FALSE)[12,1], "b")

})


test_that("Header rows write in the correct way on a sheet", {

  #Check header is in the right position, and there is a blank column above and below
  expect_equal(read.xlsx(tmp_file, colNames = FALSE, skipEmptyRows = FALSE)[5,1], "Cars")
  expect_true(is.na(read.xlsx(tmp_file, colNames = FALSE, skipEmptyRows = FALSE)[4,1]))
  expect_true(is.na(read.xlsx(tmp_file, colNames = FALSE, skipEmptyRows = FALSE)[6,1]))

})


test_that("Notes write in the correct place", {
  #Check notes are in the right position, and there is a blank column above
  expect_equal(read.xlsx(tmp_file, colNames = FALSE, skipEmptyRows = FALSE)[12,1], "b")
  expect_equal(read.xlsx(tmp_file, colNames = FALSE, skipEmptyRows = FALSE)[11,1], "a")
  expect_true(is.na(read.xlsx(tmp_file, colNames = FALSE, skipEmptyRows = FALSE)[10,1]))

})

test_that("Row merge on notes works correctly", {
  #Read data in filling across merged cells, and check which cells were merged

  expect_equal(openxlsx::read.xlsx(tmp_file, colNames = FALSE,
                                   skipEmptyRows = FALSE, fillMergedCells = TRUE)[11,1], "a")
  expect_equal(openxlsx::read.xlsx(tmp_file, colNames = FALSE,
                                   skipEmptyRows = FALSE, fillMergedCells = TRUE)[11,2], "a")
  expect_equal(openxlsx::read.xlsx(tmp_file, colNames = FALSE,
                                   skipEmptyRows = FALSE, fillMergedCells = TRUE)[11,3], "a")
  expect_true(is.na(read.xlsx(tmp_file, colNames = FALSE,
                              skipEmptyRows = FALSE, fillMergedCells = TRUE)[11,4]))
  expect_true(is.na(read.xlsx(tmp_file, colNames = FALSE,
                              skipEmptyRows = FALSE, fillMergedCells = TRUE)[11,5]))

  expect_equal(openxlsx::read.xlsx(tmp_file, colNames = FALSE,
                                   skipEmptyRows = FALSE, fillMergedCells = TRUE)[12,1], "b")
  expect_equal(openxlsx::read.xlsx(tmp_file, colNames = FALSE,
                                   skipEmptyRows = FALSE, fillMergedCells = TRUE)[12,2], "b")
  expect_equal(openxlsx::read.xlsx(tmp_file, colNames = FALSE,
                                   skipEmptyRows = FALSE, fillMergedCells = TRUE)[12,3], "b")
  expect_true(is.na(read.xlsx(tmp_file, colNames = FALSE,
                              skipEmptyRows = FALSE, fillMergedCells = TRUE)[12,4]))
  expect_true(is.na(read.xlsx(tmp_file, colNames = FALSE,
                              skipEmptyRows = FALSE, fillMergedCells = TRUE)[12,5]))

})



test_that("Not giving a list of tables throws an error", {
  a <- openxlsx::createWorkbook()
  openxlsx::addWorksheet(a, sheetName = "sheet1")

  #Check that it returns an error, and that it returns a specific message
  expect_error(save_formatted_table(workbook = a,
                                    sheet_name = "sheet1",
                                    tables = mtcars[1:3, 1:3],
                                    notes = c("a", "b"),
                                    starting_row = 3,
                                    quarterly_format = NULL))
  expect_error(save_formatted_table(workbook = a,
                                    sheet_name = "sheet1",
                                    tables = mtcars[1:3, 1:3],
                                    notes = c("a", "b"),
                                    starting_row = 3,
                                    quarterly_format = NULL), "Tables must be provided as a list")

})

test_that("Not giving a vector of notes throws an error", {
  a <- openxlsx::createWorkbook()
  openxlsx::addWorksheet(a, sheetName = "sheet1")

  #Check that it returns an error, and that it returns a specific message
  expect_error(save_formatted_table(workbook = a,
                                    sheet_name = "sheet1",
                                    tables = list(mtcars[1:3, 1:3]),
                                    notes = list("a", "b"),
                                    starting_row = 3,
                                    quarterly_format = NULL))

  expect_error(save_formatted_table(workbook = a,
                                    sheet_name = "sheet1",
                                    tables = list(mtcars[1:3, 1:3]),
                                    notes = list("a", "b"),
                                    starting_row = 3,
                                    quarterly_format = NULL), "Notes must be provided as a vector")
})

test_that("Not giving a wb or sheet throws an error", {
  expect_error(save_formatted_table(sheet_name = "sheet1",
                       tables = list(mtcars[1:3, 1:3]),
                       notes = c("a", "b"),
                       starting_row = 3,
                       quarterly_format = NULL))

  expect_error(save_formatted_table(workbook = wb,
                                    tables = list(mtcars[1:3, 1:3]),
                                    notes = c("a", "b"),
                                    starting_row = 3,
                                    quarterly_format = NULL))
})


##Delete objects
rm(tmp_file, wb)
