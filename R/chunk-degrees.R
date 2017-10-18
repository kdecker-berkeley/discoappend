#' Append degree data to a discoveryengine definition
#'
#' @param constituency A discoveryengine definition
#' @export
#' @examples
#' wealthy = has_capacity(1)
#' wealthy_degrees = degrees(wealthy)
#' display(wealthy_degrees)
#'
degrees <- function(constituency) {
  listbuilder::add_template(constituency, degrees_query_template)
}

