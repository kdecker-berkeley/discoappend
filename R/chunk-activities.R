#' Append activity data to a discoveryengine definition
#'
#' @param constituency A discoveryengine definition
#' @rdname activities
#' @export
#' @examples
#' wealthy = has_capacity(1)
#' wealthy_activities = activities(wealthy)
#' display(wealthy_activities)
#'
activities <- function(constituency) {
  listbuilder::add_template(constituency, activities_query_template)
}

