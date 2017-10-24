#' Append basic bio data to a discoveryengine definition
#'
#' @param constituency A discoveryengine definition
#' @return data frame with the following columns: entity id, last name, first name, spouse entity id, spouse last name, spouse first name, record types, home city, home state, home zip code, home county, home country, home msa
#' @rdname basic_bio
#' @export
#' @examples
#' wealthy = has_capacity(1)
#' wealthy_bio = basic_bio(wealthy)
#' display(wealthy_bio)
#'
basic_bio <- function(constituency) {
  listbuilder::add_template(constituency, basic_bio_query_template)
}

