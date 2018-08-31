#' Append last three contacts by unit to a discoveryengine definition
#'
#' @param constituency A discoveryengine definition
#' @param unit Unit code
#' @return data frame with the following columns: entity id, last contact date, last contact, second last contact date, second last contact, third last contact date, third last contact
#' @rdname contacts_by_unit
#' @export
#' @examples
#' wealthy = has_capacity(1)
#' cal_performances_contacts = contacts_by_unit(wealthy, "CP")
#' display(cal_performances_contacts)
#'
contacts_by_unit <- function(constituency, unit) {
  query <- contacts_by_unit_template
  tmpl <- getcdw::parameterize_template(query)
  chunk <- tmpl(entity_id = "##entity_id##", unit = unit)
  listbuilder::add_template(constituency, chunk)
}
