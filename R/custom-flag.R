#' Flag a constitutency
#'
#' Use within a \code{\link{custom}} chunk to "flag" a constituency with a
#' Y/N column. See examples
#'
#' @param constituency A constituency defined with the Disco Engine
#'
#' @seealso \code{\link{custom}}
#'
#' @examples
#' ## among those with a rating of 1, who attended an event in 2016?
#' wealthy = has_capacity(1)
#' event_attendee = attended_event(from = 20160101, to = 2016)
#'
#' wealthy %>%
#'   custom(
#'     event_attendee_16 = flag(event_attendee)
#'   )
#'
#' @export
flag <- function(constituency) {
  output <- "max('Y')"


  build_chunk(
    constituency, output = output,
    isgrouped = TRUE,
    fmt = na_no,
    household = TRUE,
    summarizer = "max"
  )

}
