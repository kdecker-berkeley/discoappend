#' @export
giving_to_area <- function(..., from = NULL, to = NULL) {
  res <- discoveryengine::gave_to_area(..., from = from, to = to)
  res <- unclass(res)
  res$isgrouped <- TRUE
  res$output <- "sum(benefit_aog_credited_amt)"
  res$having <- NULL
  res$column_formats = list(na_zero)
  res
}
