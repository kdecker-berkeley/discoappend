#' Append interest to a discoveryengine definition
#'
#' @param constituency A discoveryengine definition
#' @return data frame with the following columns: entity id, affiliations, interests, philanthropic interests, philanthropic affinities, philanthropic organizations
#' @rdname interests
#' @export
#' @examples
#' wealthy = has_capacity(1)
#' wealthy_ratings = rating(wealthy)
#' display(wealthy_ratings)
#'
interests <- function(constituency) {
  listbuilder::add_template(
    constituency, affiliations_query_template) %>%
    listbuilder::add_template(
    interests_query_template) %>%
    listbuilder::add_template(
    phil_interests_query_template) %>%
    listbuilder::add_template(
    phil_affinities_query_template)

}

