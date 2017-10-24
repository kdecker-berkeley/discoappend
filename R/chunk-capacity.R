#' Append rating data to a discoveryengine definition
#'
#' @param constituency A discoveryengine definition
#' @return data frame with the following columns: entity id, capacity rating code, capacity rating description, inclination rating description, builder of berkeley, implied capacity score, implied capacity description, major gift score, major gift description
#' @rdname rating
#' @export
#' @examples
#' wealthy = has_capacity(1)
#' wealthy_ratings = rating(wealthy)
#' display(wealthy_ratings)
#'
rating <- function(constituency) {
  listbuilder::add_template(
    constituency, cap_template,
    column_formats = list(capacity_rating_code = as.integer,
                          capacity_rating_desc = capacity_desc_format)) %>%
    listbuilder::add_template(
      imp_cap_template,
      column_formats = list(implied_capacity_desc = model_desc_format)) %>%
    listbuilder::add_template(
      mgs_template,
      column_formats = list(major_gift_desc = model_desc_format))
}

