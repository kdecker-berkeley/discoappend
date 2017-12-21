#' Detailed giving summaries in custom chunks
#'
#' These functions are used inside the \code{\link{custom}} function, to create
#' detailed giving summaries. They have a similar interface to the giving widgets
#' in the Discovery Engine.
#'
#' @param ... One or more codes (area/department/type, etc) or synonyms
#' @param from Start date, in the format YYYYMMDD
#' @param to End date, in the format YYYYMMDD
#'
#' @seealso \code{\link{custom}}
#'
#' @examples
#' wealthy = has_capacity(1)
#'
#' ## get total giving to campus in FY15 and FY16
#' ## as with the disco engine, i can get giving anywhere on campus
#' ## by not specifying an area
#' wealthy %>%
#'   custom(
#'     fy15_giving = giving_to_area(from = 20140701, to = 20150630),
#'     fy16_giving = giving_to_area(from = 20150701, to = 20160630)
#'   )
#'
#' ## total giving to neuro/brain related funds:
#' neuro_fund = fund_text_contains("neuro*", "brain")
#' wealthy %>%
#'   custom(neuro_giving = giving_to_fund(neuro_fund))
#'
#' @name custom_giving
NULL

custom_giving_to <- function(..., from = NULL, to = NULL, type = NULL) {
  funds <- switch (type,
                   area = discoveryengine::fund_area(...),
                   department = discoveryengine::fund_department(...),
                   type = discoveryengine::fund_type(...),
                   stop("Don't recognize fund ", type, " as a thing")
  )
  giving_to_fund(funds, from = from, to = to)
}

#' @rdname custom_giving
#' @export
giving_to_area <- function(..., from = NULL, to = NULL) {
  custom_giving_to(..., from = from, to = to, type = "area")
}

#' @rdname custom_giving
#' @export
giving_to_department <- function(..., from = NULL, to = NULL) {
  custom_giving_to(..., from = from, to = to, type = "department")
}

#' @rdname custom_giving
#' @export
giving_to_fund_type <- function(..., from = NULL, to = NULL) {
  custom_giving_to(..., from = from, to = to, type = "type")
}

#' @rdname custom_giving
#' @export
giving_to_fund <- function(..., from = NULL, to = NULL) {
  res <- discoveryengine::gave_to_fund(..., from = from, to = to)

  output <- "sum(benefit_dept_credited_amt)"
  build_chunk(res, output = output,
              isgrouped = TRUE,
              fmt = na_zero,
              household = FALSE)
}
