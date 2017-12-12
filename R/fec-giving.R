#' @export
fec_giving_to_committee <- function(..., from = NULL, to = NULL) {
  res <- discoveryengine::fec_gave_to_committee(..., from = from, to = to)
  #output <- make_extra_output(res, "sum(transaction_amt)")
  output <- "sum(transaction_amt)"

  widget_to_chunk(
    res,
    output = output,
    isgrouped = TRUE,
    fmt = na_zero,
    household = TRUE,
    summarizer = "sum"
  )

}

#' @export
fec_giving_to_category <- function(..., from = NULL, to = NULL) {
  res <- discoveryengine::fec_gave_to_category(..., from = from, to = to)
  #output <- make_extra_output(res, "sum(transaction_amt)")
  output <- "sum(transaction_amt)"

  flist_to_chunk(
    res, output = output,
    isgrouped = TRUE,
    fmt = na_zero,
    household = TRUE,
    summarizer = "sum"
  )
}

#' @export
fec_giving_to_candidate <- function(..., from = NULL, to = NULL) {
  res <- discoveryengine::fec_gave_to_candidate(..., from = from, to = to)
  #output <- make_extra_output(res, "sum(transaction_amt)")
  output <- "sum(transaction_amt)"

  flist_to_chunk(
    res, output = output,
    isgrouped = TRUE,
    fmt = na_zero,
    household = TRUE,
    summarizer = "sum"
  )
}
