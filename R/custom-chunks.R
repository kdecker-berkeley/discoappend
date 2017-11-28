#' @export
custom <- function(report, ...) {
  # check that everything in "..." has a name to use as column name of output
  args <- list(...)
  colnames <- names(args)
  coldefs <- unname(args)

  colnames <- trimws(colnames)
  colnames <- colnames[colnames != ""]
  if (length(unique(colnames)) != length(coldefs))
    stop("Not all columns have unique names")

  # each element of "args" is used to create its own chunk
  chunks <- Map(
    function(x, y) as_report_template(x, colname = y),
    coldefs, colnames
  )

  # add all of the chunks that were thus created to the original
  # definition/report. we've passed around the column formatting instructions
  # so those can be included too.
  addtemplate <- function(original, new) {
    listbuilder::add_template(original, new,
                              column_formats = attr(new, "column_formats"))
  }

  Reduce(addtemplate, x = chunks, init = report)
}

r2sql <- listbuilder:::r2sql

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

  res <- whisker::whisker.render(tmpl, data = list(
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

  if (!is.null(output$column_formats)) {
    names(output$column_formats) <- colname
    attr(res, "column_formats") <- output$column_formats
  }
  res
  }
