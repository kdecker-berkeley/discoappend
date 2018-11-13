#' Append automated capacity rating to a discoveryengine definition
#'
#' @param constituency A discoveryengine definition
#' @return data frame with the following columns: entity id, unverified_estimate
#' @export
#' @examples
#' wealthy = has_capacity(1)
#' wealthy %>% unverified_estimate %>% display
unverified_estimate <- function(constituency) {
  listbuilder::add_template(constituency, robo_rating_template)
}
