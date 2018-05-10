#' Append external screening data to a discoveryengine definition
#'
#' @param constituency A discoveryengine definition
#' @return data frame with the following columns: entity id, amedian_income, fec_matched_giving, hh_fec_matched_giving, ca_matched_giving, hh_ca_matched_giving, has_sec, is_director, is_officer, is_ten_percenter, sec_link
#' @export
#' @examples
#' wealthy = has_capacity(1)
#' wealthy %>% screening %>% display
screening <- function(constituency) {
  res <- listbuilder::add_template(constituency, median_income_query_template)
  res <- listbuilder::add_template(res, fec_query_template)
  res <- listbuilder::add_template(res, ca_query_template)
  res <- listbuilder::add_template(res, sec_query_template)
  listbuilder::add_template(res, cik_link_template)
}
