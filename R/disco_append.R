#' Append data to a discoveryengine definition
#'
#' @param ids A discoveryengine definition
#' @param include_deceased Should deceased individuals be included?
#' @param household Should there be one line per household?
#'
#' @details
#' By default, deceased individuals are exclused.
#' By default, output is one line per household.
#' @export
append_basic_bio <- function(ids, include_deceased = FALSE, household = TRUE) {
    # ensure that we have entity ids
    stopifnot(listbuilder::get_id_type(ids) == "entity_id")

    # household, etc
    ids <- modify(

        ids,
        include_organizations = FALSE,
        include_deceased = include_deceased,
        household = household)

    # run the query and return a data frame
    res <- discoveryengine::get_cdw(
        listbuilder::report(
            ids, template = basic_bio_query_template
        )
    )
res
}

append_capacity <- function(ids, include_deceased = FALSE, household = TRUE) {
  # ensure that we have entity ids
  stopifnot(listbuilder::get_id_type(ids) == "entity_id")

  # household, etc
  ids <- modify(

    ids,
    include_organizations = FALSE,
    include_deceased = include_deceased,
    household = household)

  # run the query and return a data frame
  res <- discoveryengine::get_cdw(
    listbuilder::report(
      ids, template = cap_template
    ) %>% listbuilder::add_template(imp_cap_template) %>% listbuilder::add_template(mgs_template)
  )
  res
}

append_giving <- function(ids, include_deceased = FALSE, household = TRUE) {
  # ensure that we have entity ids
  stopifnot(listbuilder::get_id_type(ids) == "entity_id")

  # household, etc
  ids <- modify(

    ids,
    include_organizations = FALSE,
    include_deceased = include_deceased,
    household = household)

  # run the query and return a data frame
  res <- discoveryengine::get_cdw(
    listbuilder::report(
      ids, template = giving_query_template
    )
  )
  res
}

append_activities <- function(ids, include_deceased = FALSE, household = TRUE) {
  # ensure that we have entity ids
  stopifnot(listbuilder::get_id_type(ids) == "entity_id")

  # household, etc
  ids <- modify(

    ids,
    include_organizations = FALSE,
    include_deceased = include_deceased,
    household = household)

  # run the query and return a data frame
  res <- discoveryengine::get_cdw(
    listbuilder::report(
      ids, template = activities_query_template
    )
  )
  res
}

append_degrees <- function(ids, include_deceased = FALSE, household = TRUE) {
  # ensure that we have entity ids
  stopifnot(listbuilder::get_id_type(ids) == "entity_id")

  # household, etc
  ids <- modify(

    ids,
    include_organizations = FALSE,
    include_deceased = include_deceased,
    household = household)

  # run the query and return a data frame
  res <- discoveryengine::get_cdw(
    listbuilder::report(
      ids, template = degrees_query_template
    )
  )
  res
}

append_employment <- function(ids, include_deceased = FALSE, household = TRUE) {
  # ensure that we have entity ids
  stopifnot(listbuilder::get_id_type(ids) == "entity_id")

  # household, etc
  ids <- modify(

    ids,
    include_organizations = FALSE,
    include_deceased = include_deceased,
    household = household)

  # run the query and return a data frame
  res <- discoveryengine::get_cdw(
    listbuilder::report(
      ids, template = emp_query_template
    )
  )
  res
}

append_prospect_info <- function(ids, include_deceased = FALSE, household = TRUE) {
  # ensure that we have entity ids
  stopifnot(listbuilder::get_id_type(ids) == "entity_id")

  # household, etc
  ids <- modify(

    ids,
    include_organizations = FALSE,
    include_deceased = include_deceased,
    household = household)

  # run the query and return a data frame
  res <- discoveryengine::get_cdw(
    listbuilder::report(
      ids, template = prospect_query_template
    )
  )
  res
}

