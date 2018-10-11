#' Append automated capacity rating to a discoveryengine definition
#'
#' @param constituency A discoveryengine definition
#' @return data frame with the following columns: entity id, median_income, fec_matched_giving, hh_fec_matched_giving, ca_matched_giving, hh_ca_matched_giving, has_sec, is_director, is_officer, is_ten_percenter, hh_has_sec, hh_is_director, hh_is_officer, hh_is_ten_percenter, sec_link, hh_sec_links
#' @export
#' @examples
#' wealthy = has_capacity(1)
#' wealthy %>% screening %>% display
robo_rating <- function(constituency) {
  listbuilder::add_template(constituency, robo_rating_template)
}
