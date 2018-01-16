library(listbuilder)

get_table.report <- function(report) get_table(report$listbuilder)
get_id_type.report <- function(report) get_id_type(report$listbuilder)
get_id_field.report <- function(report) get_id_field(report$listbuilder)

uses_table <- function(report, table) {
  expect_equal(tolower(get_table.report(report)), tolower(table))
}

id_of_type <- function(report, id_type) {
  expect_equal(get_id_type.report(report), id_type)
}

id_field_is <- function(report, id_type) {
  expect_equal(tolower(get_id_field.report(report)), tolower(id_type))
}
