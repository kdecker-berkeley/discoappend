#' Append data to a discoveryengine definition
#'
#' @param constituency A discoveryengine definition
#' @export

basic_bio <- function(constituency) {
  listbuilder::add_template(constituency, basic_bio_query_template)
}

capacity <- function(constituency) {
  listbuilder::add_template(constituency, cap_template) %>%
    listbuilder::add_template(imp_cap_template) %>%
    listbuilder::add_template(mgs_template)
}

activities <- function(constituency) {
  listbuilder::add_template(constituency, activities_query_template)
}

giving <- function(constituency) {
  listbuilder::add_template(constituency, giving_query_template)
}

degrees <- function(constituency) {
  listbuilder::add_template(constituency, degrees_query_template)
}

employment <- function(constituency) {
  listbuilder::add_template(constituency, emp_query_template)
}

prospect <- function(constituency) {
  listbuilder::add_template(constituency, prospect_query_template)
}

append <- function(constituency, ...) {
  chunks <- list(...)
  result <- constituency
  for (chunk_index in seq_along(chunks)) {
    result <- chunks[[chunk_index]](result)
  }
  result
}

