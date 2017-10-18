#' Append basic bio data to a discoveryengine definition
#'
#' @param constituency A discoveryengine definition
#' @export
#' @examples
#' wealthy = has_capacity(1)
#' wealthy_bio = basic_bio(wealthy)
#' display(wealthy_bio)
#'
basic_bio <- function(constituency) {
  listbuilder::add_template(constituency, basic_bio_query_template)
}

