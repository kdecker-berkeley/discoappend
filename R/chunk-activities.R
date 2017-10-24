#' Append activity data to a discoveryengine definition
#'
#' @param constituency A discoveryengine definition
#' @return data frame with the following columns: entity id, student activities, sports
#' @export
#' @examples
#' wealthy = has_capacity(1)
#' wealthy_activities = activities(wealthy)
#' display(wealthy_activities)
#'
activities <- function(constituency) {
  listbuilder::add_template(constituency, activities_query_template)
}

