#' Append prospect data to a discoveryengine definition
#'
#' @param constituency A discoveryengine definition
#' @rdname prospect
#' @export
#' @examples
#' wealthy = has_capacity(1)
#' wealthy_prospect = prospect(wealthy)
#' display(wealthy_prospect)
#'
prospect <- function(constituency) {
  listbuilder::add_template(constituency, prospect_query_template)
}
