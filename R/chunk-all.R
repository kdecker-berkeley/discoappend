#' Append all available chunks to a discoveryengine definition
#'
#' @param constituency A discoveryengine definition
#' @return data frame with columns from all available chunks
#' See \code{\link{basic_bio}},
#' \code{\link{degrees}}
#' \code{\link{employment}}
#' \code{\link{rating}}
#' \code{\link{screening}}
#' \code{\link{activities}}
#' \code{\link{interests}}
#' \code{\link{prospect}}
#' \code{\link{giving}}
#'
#' @export
#' @examples
#' wealthy = has_capacity(1)
#' wealthy_data = all_chunks(wealthy)
#' display(wealthy_data)
#'
all_chunks <- function(constituency) {
  listbuilder::add_template(constituency, basic_bio_query_template) %>%
  listbuilder::add_template(degrees_query_template) %>%
  listbuilder::add_template(emp_query_template) %>%
  listbuilder::add_template(cap_template,
    column_formats = list(capacity_rating = capacity_desc_format)) %>%
  listbuilder::add_template(inclination_template) %>%
  listbuilder::add_template(imp_cap_template,
    column_formats = list(implied_capacity_desc = model_desc_format)) %>%
  listbuilder::add_template(mgs_template,
    column_formats = list(major_gift_score_desc = model_desc_format)) %>%
  listbuilder::add_template(cnr_model_template,
    column_formats = list(cnr_score_desc = model_desc_format)) %>%
  listbuilder::add_template(gp_template,
    column_formats = list(gift_planning_score_desc = model_desc_format)) %>%
  listbuilder::add_template(eng_model_template,
    column_formats = list(engineering_score_desc = model_desc_format)) %>%
  listbuilder::add_template(haas_model_template,
    column_formats = list(haas_score_desc = model_desc_format)) %>%
  listbuilder::add_template(median_income_query_template) %>%
  listbuilder::add_template(fec_query_template) %>%
  listbuilder::add_template(ca_query_template) %>%
  listbuilder::add_template(activities_query_template) %>%
  listbuilder::add_template(affiliations_query_template) %>%
  listbuilder::add_template(interests_query_template) %>%
  listbuilder::add_template(phil_interests_query_template) %>%
  listbuilder::add_template(phil_affinities_query_template) %>%
  listbuilder::add_template(prospect_query_template,
    column_formats = list(event_count = na_zero)) %>%
  listbuilder::add_template(giving_query_template,
    column_formats = list(
      lifetime_giving = na_zero,
      largest_gift = na_zero,
      last_gift = na_zero,
      average_gift = na_zero,
      outstanding_pledges = na_zero
      ))

}

