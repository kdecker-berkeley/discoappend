#' Create custom output columns for a discovery engine definition
#'
#' The report chunks that are listed in \code{\link{show_chunks}} provide
#' high-level summarized views of entities, useful for quick spot-checking and
#' basic ad-hoc reporting. In contrast, custom chunks are report chunks that
#' are shaped by user-provided parameters (for instance, instead of getting
#' lifetime giving summaries, you might want summarized giving for each of the
#' past few years). See examples below.
#'
#' @section Note:
#' All column names will be converted to lowercase. It is suggested you use
#' lowercase when naming your custom columns to avoid confusion.
#'
#'
#' @param report Either a disco engine definition, or a partial report created
#' by appending one or more chunks to a disco engine definition
#' @param ... named descriptions of custom columns to add to output. Add as many
#' custom columns as necessary.
#'
#' @examples
#' wealthy = has_capacity(1)
#'
#' ## lifetime giving summarized by area
#' wealthy %>%
#'   custom(business_giving = giving_to_area(business),
#'          athletics_giving = giving_to_area(athletics))
#'
#' ## use "flags" to create Yes/No columns. any disco engine definition
#' ## can be used to create a flag:
#' environmental_interest = has_interest(environment)
#' wealthy %>%
#'   custom(environmnetalist = flag(environmental_interest))
#'
#' @seealso \code{\link{custom_giving_chunks}}, \code{\link{custom_fec_chunks}},
#' \code{\link{flag}}
#'
#' @export
custom <- function(report, ...) {
  if (!inherits(report, "listbuilder") & !inherits(report, "report"))
    stop("custom requires a disco engine definition or part of a report")

  # check that everything in "..." has a name to use as column name of output
  args <- list(...)
  colnames <- names(args)
  coldefs <- unname(args)

  colnames <- trimws(colnames)
  colnames <- colnames[colnames != ""]
  if (length(unique(colnames)) != length(coldefs))
    stop("Not all columns have unique names")

  if (any(grepl("^hh_", colnames)))
    stop("Custom column names can not begin with 'hh_', please use a different name")

  ## raw disco engine definitions should be treated as flag()s
  coldefs <- lapply(coldefs,
                    function(def)
                      if (inherits(def, "listbuilder")) flag(def) else def)

  needs_householding <- which(
    vapply(coldefs, function(x) isTRUE(x$household), logical(1))
  )

  # each element of "args" is used to create its own chunk
  chunks <- Map(
    function(x, y) as_report_template(x, colname = y),
    coldefs, colnames
  )

  names(chunks) <- colnames

  if (length(needs_householding) > 0) {
    extra_chunks <- Map(
      function(x, y) hh_version(x, y, summarizer = x$summarizer),
      coldefs[needs_householding], colnames[needs_householding]
    )
    names(extra_chunks) <- paste0("hh_", colnames[needs_householding])
  } else {
    extra_chunks <- list()
  }

  chunks <- c(chunks, extra_chunks)

  colnames <- as.list(colnames)
  colnames[needs_householding] <- lapply(
    colnames[needs_householding],
    function(x) c(x, paste0("hh_", x))
  )
  colnames <- unlist(colnames)
  chunks <- chunks[colnames]

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
  paste(output, "as", colname)
}

as_report_template <- function(output, colname) {
  tmpl <- "
  select
  {{{id_field}}} as ##{{{id_type}}}##,
  {{{columnspecs}}}
  from ({{{from}}})
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

  if (!is.null(output$column_formats)) {
    attr(res, "column_formats") <- structure(
      list(output$column_formats),
      names = colname)
  }
  res
}
