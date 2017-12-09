#' @export
fec_giving_to_committee <- function(..., from = NULL, to = NULL) {
  res <- discoveryengine::fec_gave_to_committee(..., from = from, to = to)
  widget_to_chunk(
    res,
    output = "sum(transaction_amt)",
    isgrouped = TRUE,
    fmt = na_zero
  )

}

#' @export
fec_giving_to_category <- function(..., from = NULL, to = NULL) {
  res <- discoveryengine::fec_gave_to_category(..., from = from, to = to)

  flist_to_chunk(
    res, output = "sum(transaction_amt)",
    isgrouped = TRUE,
    fmt = na_zero
  )
}

#' @export
fec_giving_to_candidate <- function(..., from = NULL, to = NULL) {
  res <- discoveryengine::fec_gave_to_candidate(..., from = from, to = to)

  flist_to_chunk(
    res, output = "sum(transaction_amt)",
    isgrouped = TRUE,
    fmt = na_zero
  )
}
