#' Append employment data to a discoveryengine definition
#'
#' @param constituency A discoveryengine definition
#' @rdname employment
#' @export
#' @examples
#' wealthy = has_capacity(1)
#' wealthy_employment = employment(wealthy)
#' display(wealthy_employment)
#'
employment <- function(constituency) {
  listbuilder::add_template(constituency, emp_query_template)
}
