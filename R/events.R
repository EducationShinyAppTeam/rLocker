#' events
#' @import htmltools httr

# Not in use currently

#' @export
observeEvents <- function(session, config) {
  session$sendCustomMessage("custom-action", config)
}
