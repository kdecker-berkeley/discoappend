#' Append degree data to a discoveryengine definition
#'
#' @param constituency A discoveryengine definition
#' @return data frame with the following columns: entity id, undergrad degree, graduate degree, degrees, class campaign year, spouse undergraduate degree, spouse graduate degree, spouse degrees, spouse class campaign year
#' @rdname degrees
#' @export
#' @examples
#' wealthy = has_capacity(1)
#' wealthy_degrees = degrees(wealthy)
#' display(wealthy_degrees)
#'
degrees <- function(constituency) {
  listbuilder::add_template(constituency, degrees_query_template)
}

