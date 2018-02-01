chunk_df <- function() {
  filename <- system.file("extdata", "chunk_finder.csv", package = "discoappend")
  read.csv(filename, stringsAsFactors = FALSE,
           colClasses = "character")
}

#' Browse the available chunk names and outputs
#'
#' Pops up an interactive table that allows you to sort and search through a
#' listing of all available chunks with outputs for each
#'
#' @export
show_chunks <- function() {
  if (!requireNamespace("DT", quietly = TRUE)) {
    stop('DT package needed for show_widgets to work.\n',
         'To install: install.packages("DT")',
         call. = FALSE)
  }

  chunk_list <- chunk_df()
  DT::datatable(chunk_list, rownames = FALSE,
                options = list(
                  order = list(list(1, "asc"))
                ))
}
