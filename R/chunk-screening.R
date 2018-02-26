#' Append external screening data to a discoveryengine definition
#'
#' @param constituency A discoveryengine definition
#' @return data frame with the following columns: entity id, acs_median_income, fec_matched_giving, hh_fec_matched_giving
#' @export
#' @examples
#' wealthy = has_capacity(1)
#' wealthy %>% screening %>% display
screening <- function(constituency) {
  res <- listbuilder::add_template(constituency, median_income_query_template)
  res <- listbuilder::add_template(res, fec_query_template)
  listbuilder::add_template(res, ca_query_template)
}
