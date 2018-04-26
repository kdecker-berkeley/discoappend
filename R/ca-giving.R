#' Detailed CA campaign giving summaries in custom chunks
#'
#' These functions are used inside the \code{\link{custom}} function, to create
#' detailed summaries of California state level political contributions. They have a similar
#' interface to the ca_gave_to_* widgets in the Discovery Engine.
#'
#' @param ... One or more codes (candidate/proposition)
#' @param from Start date, in the format YYYYMMDD
#' @param to End date, in the format YYYYMMDD
#' @param support TRUE/FALSE, whether to look for supporters (TRUE) or those opposed (FALSE) to the ballot initiative. Defailts to both (support and oppose)
#'
#' @seealso \code{\link{custom}}
#'
#' @examples
#' wealthy = has_capacity(1)
#'
#' ## summary of all giving to CA state level campaigns to candidates
#' wealthy %>%
#'   custom(
#'     ca_giving = ca_giving_to_candidate()
#'   )
#'
#' ## find donors to Kamala Harris (whose code is CA770144) and append amounts
#' ca_gave_to_candidate(CA770144) %>%
#' custom(
#' harris_giving = ca_giving_to_candidate(CA770144)
#' )
#'
#' @name custom_ca_giving
NULL

#' @rdname custom_ca_giving
#' @export
ca_giving_to_proposition <- function(..., from = NULL, to = NULL, support = NULL) {
  res <- discoveryengine::ca_gave_to_proposition(..., from = from, to = to, support = support)
  output <- "sum(amount)"

  build_chunk(
    res,
    output = output,
    isgrouped = TRUE,
    fmt = na_zero,
    household = TRUE,
    summarizer = "sum"
  )

}


#' @rdname custom_ca_giving
#' @export
ca_giving_to_candidate <- function(..., from = NULL, to = NULL) {
  res <- discoveryengine::ca_gave_to_candidate(..., from = from, to = to)
  output <- "sum(amount)"

  build_chunk(
    res, output = output,
    isgrouped = TRUE,
    fmt = na_zero,
    household = TRUE,
    summarizer = "sum"
  )
}
