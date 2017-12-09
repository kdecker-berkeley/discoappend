make_extra_output <- function(res, output) {
  if (is.null(res$where))
    add_clause <- ""
  else
    add_clause <- paste0(" and ", paste(r2sql(res$where), collapse = " and "))

  sp_out_tmpl <- "(
  select {{{outp}}}
  from cdw.d_entity_mv ent
  inner join {{{schema}}}.{{{table}}} tbl__sp on ent.spouse_entity_id = tbl__sp.entity_id
  where ent.entity_id = {{{table}}}.entity_id {{{add_clause}}})
  "

  sp <- whisker::whisker.render(
    sp_out_tmpl, data = list(
      outp = output,
      table = res$table,
      schema = res$schema,
      add_clause = add_clause
    )
  )

  hh_out_tmpl <- "
  nvl({{{outp}}}, 0) +
  nvl((
  select {{{outp}}} from cdw.d_entity_mv ent
  inner join {{{schema}}}.{{{table}}} tbl__hh on ent.spouse_entity_id = tbl__hh.entity_id
  where ent.entity_id = {{{table}}}.entity_id {{{add_clause}}}
  ), 0)
  "

  hh <- whisker::whisker.render(
    hh_out_tmpl, data = list(
      outp = output,
      table = res$table,
      schema = res$schema,
      add_clause = add_clause
    )
  )

  list(list(
    def = output, prefix = ""
  ), list(
    def = sp, prefix = "sp_"
  ), list(
    def = hh, prefix = "hh_"
  ))
}

flist_to_chunk <- function(res, output, isgrouped, fmt) {
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
  res$output <- make_extra_output(res, output)
  res$column_formats = fmt
  res
}

widget_to_chunk <- function(res, output, isgrouped, fmt) {
  res$from <- paste0(res$schema, ".", res$table)
  res$isgrouped <- isgrouped
  res$column_formats <- fmt
  res$having <- NULL
  res$output <- make_extra_output(res, output)
  res
}
