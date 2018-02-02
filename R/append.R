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
  chunks <- eval(substitute(alist(...)))
  chunks <- vapply(chunks, deparse, FUN.VALUE = character(1))
  check <- vapply(chunks, exists, FUN.VALUE = logical(1), envir = valid_chunks())

  if (any(!check)) {
    msg <- paste(chunks[!check], collapse = ", ")
    stop("unrecognized chunk(s): ", msg, call. = FALSE)
  }

  chunks <- lapply(chunks, get, envir = valid_chunks())
  result <- constituency
  for (chunk in chunks) {
    result <- chunk(result)
  }
  result
}

valid_chunks <- function() {
  chunk_names <- chunk_df()$chunk_name
  chunks <- lapply(chunk_names, as.name)
  chunks <- lapply(chunks, eval, envir = parent.env(environment()))
  list2env(structure(chunks, names = chunk_names),
           parent = emptyenv())
}
