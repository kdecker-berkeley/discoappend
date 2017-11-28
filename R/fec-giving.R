#' @export
fec_giving_to_committee <- function(..., from = NULL, to = NULL) {
  res <- discoveryengine::fec_gave_to_committee(..., from = from, to = to)
  res <- unclass(res)
  res$isgrouped <- TRUE
  res$output <- "sum(transaction_amt)"
  res$having <- NULL
  res$column_formats = list(na_zero)
  res
}

#' @export
fec_giving_to_category <- function(..., from = NULL, to = NULL) {
  # res <- fec_gave_to_category(environmental_policy)
  res <- discoveryengine::fec_gave_to_category(..., from = from, to = to)

  cmte_qry <- discoveryengine::to_sql(res$rhs)

  res <- unclass(res)

  res$id_field <- "entity_id"
  res$where <- list(dbplyr::sql(paste0("cmte_id in (", cmte_qry, ")")))
  res$isgrouped <- TRUE
  res$output <- "sum(transaction_amt)"
  res$having <- NULL
  res$column_formats = list(na_zero)
  res
}
