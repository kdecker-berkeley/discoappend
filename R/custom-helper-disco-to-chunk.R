flist_to_chunk <- function(res, output, isgrouped, fmt, household,
                           summarizer = "sum") {
  id_col <- res$from

  if (res$table == "custom") {
    res$from <- res$custom
  } else {
    res$from <- paste0(res$schema, ".", res$table)
  }

  inner_qry <- discoveryengine::to_sql(res$rhs)
  res <- unclass(res)
  res$id_field <- res$to

  res$where <- c(
    res$where,
    list(dbplyr::sql(paste0(id_col, " in (", inner_qry, ")")))
  )

  res$isgrouped <- isgrouped
  res$having <- NULL
  res$output <- output
  res$household <- household
  res$column_formats = fmt
  res$summarizer <- summarizer
  res
}

widget_to_chunk <- function(def, output, isgrouped, fmt,
                            household, summarizer = "sum") {
  res <- list()
  res$household <- household

  tbl <- listbuilder::get_table(def)
  if (tbl == "custom")
    res$from <- def$custom
  else if (tbl == "manual")
    res$from <- listbuilder::to_sql(def)
  else res$from <- paste0(listbuilder::get_schema(def),
                          ".",
                          listbuilder::get_table(def))
  res$isgrouped <- isgrouped
  res$column_formats <- fmt
  res$having <- NULL
  res$output <- output
  res$id_type <- listbuilder::get_id_type(def)
  res$id_field <- listbuilder::get_id_field(def)
  res$where <- listbuilder::get_where(def)
  res$summarizer <- summarizer
  res
}
