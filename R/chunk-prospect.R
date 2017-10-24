#' Append prospect data to a discoveryengine definition
#'
#' @param constituency A discoveryengine definition
#' @return data frame with the following columns: entity id, active major proposal flg, active annual proposal flg, proposals, primary manager, primary manager office, last 3 events, event count, last contact, university signature
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
