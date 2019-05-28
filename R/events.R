#' events
#' @import htmltools httr

#' @export
observeEvents <- function(session, config) {
  session$sendCustomMessage("custom-action", config)
}
