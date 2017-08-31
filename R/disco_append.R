#' Append data to a discoveryengine definition
#'
#' @param constituency A discoveryengine definition
#' @param ... One or more sections to be appended
#'
#' @examples
#' library(discoveryengine)
#' wealthy = has_capacity(1)
#' display(basic_bio(wealthy))
#'
#' display(append(wealthy, basic_bio, capacity, activities))
#'
#' @export
#' @name append
basic_bio <- function(constituency) {
  listbuilder::add_template(constituency, basic_bio_query_template)
}

#' @export
#' @rdname append
capacity <- function(constituency) {
  listbuilder::add_template(
    constituency, cap_template,
    column_formats = list(capacity_rating_code = as.integer,
                          capacity_rating_desc = capacity_desc_format)) %>%
    listbuilder::add_template(
      imp_cap_template,
      column_formats = list(implied_capacity_desc = model_desc_format)) %>%
    listbuilder::add_template(
      mgs_template,
      column_formats = list(major_gift_desc = model_desc_format))
}

#' @export
#' @rdname append
activities <- function(constituency) {
  listbuilder::add_template(constituency, activities_query_template)
}

#' @export
#' @rdname append
giving <- function(constituency) {
  listbuilder::add_template(constituency, giving_query_template)
}


#' @export
#' @rdname append
degrees <- function(constituency) {
  listbuilder::add_template(constituency, degrees_query_template)
}

#' @export
#' @rdname append
employment <- function(constituency) {
  listbuilder::add_template(constituency, emp_query_template)
}

#' @export
#' @rdname append
prospect <- function(constituency) {
  listbuilder::add_template(constituency, prospect_query_template)
}

#' @export
#' @rdname append
append <- function(constituency, ...) {
  chunks <- list(...)
  result <- constituency
  for (chunk_index in seq_along(chunks)) {
    result <- chunks[[chunk_index]](result)
  }
  result
}

