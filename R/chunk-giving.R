#' Append giving data to a discoveryengine definition
#'
#' @param constituency A discoveryengine definition
#' @return data frame with the following columns: entity id, lifetime giving, largest gift, largest gift date, largest gift area, last gift, last gift date, last gift area, average gift, outstanding pledges
#' @rdname giving
#' @export
#' @examples
#' wealthy = has_capacity(1)
#' wealthy_giving = giving(wealthy)
#' display(wealthy_giving)
#'
giving <- function(constituency) {
  listbuilder::add_template(constituency, giving_query_template)
}


