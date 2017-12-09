custom_giving_to <- function(..., from = NULL, to = NULL, type = NULL) {
  funds <- switch (type,
                   area = discoveryengine::fund_area(...),
                   department = discoveryengine::fund_department(...),
                   type = discoveryengine::fund_type(...),
                   stop("Don't recognize fund ", type, " as a thing")
  )
  giving_to_fund(funds, from = from, to = to)
}

#' @export
giving_to_area <- function(..., from = NULL, to = NULL) {
  custom_giving_to(..., from = from, to = to, type = "area")
}

#' @export
giving_to_department <- function(..., from = NULL, to = NULL) {
  custom_giving_to(..., from = from, to = to, type = "department")
}

#' @export
giving_to_fund_type <- function(..., from = NULL, to = NULL) {
  custom_giving_to(..., from = from, to = to, type = "type")
}

#' @export
giving_to_fund <- function(..., from = NULL, to = NULL) {
  res <- discoveryengine::gave_to_fund(..., from = from, to = to)

  output <- list(list(def = "sum(benefit_dept_credited_amt)",
                      prefix = ""))

  flist_to_chunk(res, output = output,
                 isgrouped = TRUE,
                 fmt = na_zero)
}
