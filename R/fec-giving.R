#' Detailed FEC summaries in custom chunks
#'
#' These functions are used inside the \code{\link{custom}} function, to create
#' detailed summaries of federal political contributions. They have a similar
#' interface to the fec_gave_to_* widgets in the Discovery Engine.
#'
#' @param ... One or more codes (committee/candidate/category) or synonyms
#' @param from Start date, in the format YYYYMMDD
#' @param to End date, in the format YYYYMMDD
#'
#' @seealso \code{\link{custom}}
#'
#' @examples
#' wealthy = has_capacity(1)
#'
#' ## summary of all giving to FEC
#' wealthy %>%
#'   custom(
#'     fec_giving = fec_giving_to_committee()
#'   )
#'
#' ## giving to environmental PACS
#' wealthy %>%
#'   custom(
#'     env_giving = fec_giving_to_category(environmental_policy)
#'   )
#'
#' @name custom_fec_giving
NULL

#' @rdname custom_fec_giving
#' @export
fec_giving_to_committee <- function(..., from = NULL, to = NULL) {
  res <- discoveryengine::fec_gave_to_committee(..., from = from, to = to)
  output <- "sum(transaction_amt)"

  build_chunk(
    res,
    output = output,
    isgrouped = TRUE,
    fmt = na_zero,
    household = TRUE,
    summarizer = "sum"
  )

}

#' @rdname custom_fec_giving
#' @export
fec_giving_to_category <- function(..., from = NULL, to = NULL) {
  res <- discoveryengine::fec_gave_to_category(..., from = from, to = to)
  output <- "sum(transaction_amt)"

  build_chunk(
    res, output = output,
    isgrouped = TRUE,
    fmt = na_zero,
    household = TRUE,
    summarizer = "sum"
  )
}

#' @rdname custom_fec_giving
#' @export
fec_giving_to_candidate <- function(..., from = NULL, to = NULL) {
  res <- discoveryengine::fec_gave_to_candidate(..., from = from, to = to)
  output <- "sum(transaction_amt)"

  build_chunk(
    res, output = output,
    isgrouped = TRUE,
    fmt = na_zero,
    household = TRUE,
    summarizer = "sum"
  )
}
