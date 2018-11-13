#' Append rating data to a discoveryengine definition
#'
#' @param constituency A discoveryengine definition
#' @return data frame with the following columns: entity id, capacity rating, capacity rating date, implied capacity score, implied capacity description, implied capacity score date, major gift score, major gift description, major gift score date, CNR score, CNR score description, CNR score date, Gift Planning score, Gift Planning score description, Gift Planning score date, Engineering score, Engineering score description, Engineering score date, Haas score, Haas score description, Haas score date
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
    column_formats = list(capacity_rating = capacity_desc_format)) %>%
    listbuilder::add_template(
      imp_cap_template,
      column_formats = list(implied_capacity_desc = model_desc_format)) %>%
    listbuilder::add_template(
      mgs_template,
      column_formats = list(major_gift_score_desc = model_desc_format)) %>%
    listbuilder::add_template(
      cnr_model_template,
      column_formats = list(cnr_score_desc = model_desc_format)) %>%
    listbuilder::add_template(
      gp_template,
      column_formats = list(gift_planning_score_desc = model_desc_format)) %>%
    listbuilder::add_template(
      eng_model_template,
      column_formats = list(engineering_score_desc = model_desc_format)) %>%
    listbuilder::add_template(
      haas_model_template,
      column_formats = list(haas_score_desc = model_desc_format))

}

