daterange <- discoveryengine:::daterange
prep_dots <- discoveryengine:::prep_dots
string_param = discoveryengine:::string_param
string_switch = discoveryengine:::string_switch
r2sql <- listbuilder:::r2sql
sum_output <- function(field_name) {
  paste0("sum(", field_name, ")")
}

as_lb_template <- function(output) {
  tmpl <- "
select
  {{{table}}}.{{{id_field}}} as ##{{{id_type}}}##,
  {{{output_coldef}}} as {{{output_colname}}}
from {{{schema}}}.{{{table}}}
{{#haswhere}}
where {{{where}}}
{{/haswhere}}
{{#isgrouped}}
group by {{{table}}}.{{{id_field}}}
{{/isgrouped}}
{{#hashaving}}
having {{{having}}}
{{/hashaving}}
"
  where <- output$where
  if (!is.null(where)) where <- r2sql(where)
  haswhere <- length(where) > 0
  where <- paste(where, collapse = " and ")
  having <- output$having
  if (!is.null(having)) having <- r2sql(having)
  hashaving <- length(having) > 0
  having <- paste(having, collapse = " and ")

  output_coldef <- output$output[[1]]
  output_colname <- names(output$output)[1]

  whisker::whisker.render(tmpl, data = list(
    table = output$table,
    haswhere = haswhere,
    where = where,
    isgrouped = output$isgrouped,
    hashaving = hashaving,
    having = having,
    id_field = output$id_field,
    id_type = output$id_type,
    schema = output$schema,
    output_coldef = output_coldef,
    output_colname = output_colname
  ))
}

output_builder <- function(table, id_field,
                           output_col,
                           parameter = NULL,
                           aggregate_parameter = NULL,
                           switches = NULL, aggregate_switches = NULL,
                           isgrouped,
                           schema = "CDW") {

  res <- discoveryengine:::widget_builder(
    table = table,
    id_field = id_field,
    id_type = "entity_id",
    parameter = parameter,
    aggregate_parameter = aggregate_parameter,
    switches = switches,
    aggregate_switches = aggregate_switches,
    schema = schema
  )

  res <- unclass(res)
  res <- c(res, isgrouped = isgrouped, list(output = output_col))

  res
}

giving_to_area_chunk <- function(aogs, from = NULL, to = NULL) {
  output_builder(
    table = "f_transaction_detail_mv",
    id_field = "donor_entity_id_nbr",
    parameter = string_param("alloc_school_code", aogs),
    switches = list(daterange("giving_record_dt", from, to),
                    string_switch("pledged_basis_flg", "Y")),
    output_col = list(giv2area = sum_output("benefit_aog_credited_amt")),
    isgrouped = TRUE
  )
}
