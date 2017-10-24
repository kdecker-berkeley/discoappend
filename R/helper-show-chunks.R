chunk_df <- function() {
  chunk_finder <- readr::read_csv("R:/Prospect Development/Prospect Analysis/discoappend/extdata/chunk_finder.csv",
                                  col_types = readr::cols(
                                    chunk_name = readr::col_character(),
                                    output = readr::col_character()
                                  ))
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
