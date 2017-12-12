hh_version <- function(coldef, colname, summarizer) {
  base <- as_report_template(coldef, colname)
  tmpl <- "
  select
  dupe.entity_id as ##entity_id##,
  max(hh_{{{colname}}}) as hh_{{{colname}}} from (
  select
  ent.household_entity_id,
  {{{summarizer}}}({{{colname}}}) as hh_{{{colname}}}
  from (
  {{{base}}}
  ) ind inner join cdw.d_entity_mv ent on
  ind.entity_id = ent.entity_id
  group by ent.household_entity_id) undupe
  inner join cdw.d_entity_mv dupe
  on undupe.household_entity_id = dupe.household_entity_id
  group by dupe.entity_id
  "

  res <- whisker::whisker.render(
    tmpl, data = list(
      base = base,
      colname = colname,
      summarizer = summarizer
    ))

  if (!is.null(attr(base, "column_formats"))) {
    attr(res, "column_formats") <- structure(
      attr(base, "column_formats"),
      names = paste0("hh_", colname))
  }
  res
}
