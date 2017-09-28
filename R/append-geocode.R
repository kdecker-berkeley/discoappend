#' @export
#' @rdname append
geocode <- function(constituency) {
  listbuilder::add_template(constituency, geocode_query_template)
}
