#' @export
flag <- function(constituency) {
  output <- "max('Y')"

  if (inherits(constituency, "idlist")) {
    return(
      widget_to_chunk(
        constituency, output = output,
        isgrouped = TRUE,
        fmt = na_no,
        household = TRUE,
        summarizer = "max"
      )
    )
  }

  if (listbuilder:::is_flist.listbuilder(constituency)) {
    return(
      flist_to_chunk(
        constituency, output = output,
        isgrouped = TRUE,
        fmt = na_no,
        household = TRUE,
        summarizer = "max")
    )}


  return(
    widget_to_chunk(
      constituency, output = output,
      isgrouped = TRUE,
      fmt = na_no,
      household = TRUE,
      summarizer = "max")
  )
}
