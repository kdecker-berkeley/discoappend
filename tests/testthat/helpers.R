get_table.report <- function(report) listbuilder::get_table(report$listbuilder)
get_id_field.report <- function(report) listbuilder::get_id_field(report$listbuilder)

uses_table <- function(report, table) {
  expect_equal(tolower(listbuilder::get_table(report)), tolower(table))
}

id_of_type <- function(report, id_type) {
  expect_equal(listbuilder::get_id_type(report), id_type)
}

id_field_is <- function(report, id_type) {
  expect_equal(tolower(listbuilder::get_id_field(report)), tolower(id_type))
}
