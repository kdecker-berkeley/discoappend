#' Append data to a discoveryengine definition
#'
#' @param constituency A discoveryengine definition
#' @param ... One or more chunks to be appended
#' @rdname append
#' @export
#' @examples
#' wealthy = has_capacity(1)
#' wealthy_data = append(wealthy, basic_bio, capacity, giving)
#' display(wealthy_data)
#'
#' See show_chunks() to search all available chunks and outputs.
append <- function(constituency, ...) {
  chunks <- list(...)
  result <- constituency
  for (chunk_index in seq_along(chunks)) {
    result <- chunks[[chunk_index]](result)
  }
  result
}

