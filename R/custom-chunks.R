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

build_columnspecs <- function(output, colname) {
  res <- vapply(output,
                function(x) paste0(x$def, " as ", x$prefix, colname),
                character(1))
  paste(res, collapse = ", ")
}

as_report_template <- function(output, colname) {
  tmpl <- "
  select
  {{{id_field}}} as ##{{{id_type}}}##,
  {{{columnspecs}}}
  from ({{from}})
  {{#haswhere}}
  where {{{where}}}
  {{/haswhere}}
  {{#isgrouped}}
  group by {{{id_field}}}
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

  columnspecs <- build_columnspecs(output$output, colname)

  res <- whisker::whisker.render(tmpl, data = list(
    from = output$from,
    haswhere = haswhere,
    where = where,
    isgrouped = output$isgrouped,
    hashaving = hashaving,
    having = having,
    id_field = output$id_field,
    id_type = output$id_type,
    columnspecs = columnspecs
  ))

  all_colnames <- vapply(output$output, function(x) x$prefix, character(1))
  all_colnames <- paste0(all_colnames, colname)

  if (!is.null(output$column_formats)) {
    fmts <- replicate(length(all_colnames), output$column_formats)
    names(fmts) <- all_colnames
    attr(res, "column_formats") <- fmts
  }
  res
}
