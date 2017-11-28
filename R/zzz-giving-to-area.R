custom <- function(report, ...) {
  # make sure all arguments are named (somehow)
  args <- list(...)
  colnames <- names(args)
  coldefs <- unname(args)

  colnames <- trimws(colnames)
  colnames <- colnames[colnames != ""]
  if (length(unique(colnames)) != length(coldefs))
    stop("Not all columns have unique names")

  chunks <- Map(
    function(x, y) as_report_template(x, colname = y),
    coldefs, colnames
  )

  Reduce(listbuilder::add_template, x = chunks, init = report)
}

r2sql <- listbuilder:::r2sql

# outcols <- function(output) {
#   tmpl <- "{{{output_coldef}}} as {{{output_colname}}}"
#
#   colnames <- names(output)
#   colnames <- trimws(colnames)
#   colnames <- colnames[colnames != ""]
#   if (length(unique(colnames)) != length(output))
#     stop("Not all columns have unique names")
#
#   output <- Map(function(x, y) list(output_colname = x, output_coldef = y),
#       colnames, unname(output))
#
#   snippet <- lapply(output, function(x)
#     whisker::whisker.render(tmpl, data = x))
#
#   paste(snippet, collapse = ",\n")
#
# }



as_report_template <- function(output, colname) {
  tmpl <- "
select
  {{{table}}}.{{{id_field}}} as ##{{{id_type}}}##,
  {{{output_spec}}} as {{{colname}}}
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
    output_spec = unname(output$output),
    colname = colname
  ))
}

giving_to_area_chunk <- function(..., from = NULL, to = NULL) {
  res <- gave_to_area(..., from = from, to = to)
  res <- unclass(res)
  res$isgrouped <- TRUE
  res$output <- "sum(benefit_aog_credited_amt)"
  res$having <- NULL
  res
}
