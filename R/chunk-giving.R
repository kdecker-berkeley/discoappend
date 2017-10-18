#' Append giving data to a discoveryengine definition
#'
#' @param constituency A discoveryengine definition
#' @export
#' @examples
#' wealthy = has_capacity(1)
#' wealthy_giving = giving(wealthy)
#' display(wealthy_giving)
#'
giving <- function(constituency) {
  listbuilder::add_template(constituency, giving_query_template)
}


