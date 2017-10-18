#' Append capacity data to a discoveryengine definition
#'
#' @param constituency A discoveryengine definition
#' @rdname capacity
#' @export
#' @examples
#' wealthy = has_capacity(1)
#' wealthy_capacity = capacity(wealthy)
#' display(wealthy_capacity)
#'
capacity <- function(constituency) {
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

