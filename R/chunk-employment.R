#' Append employment data to a discoveryengine definition
#'
#' @param constituency A discoveryengine definition
#' @return data frame with the following columns: entity id, employer entity id, employer name, job title, position level, field of work, sic code, business city, business state, business zip code
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
