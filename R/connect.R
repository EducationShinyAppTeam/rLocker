#'connect
#'
#' @name connect
#'
#' @import htmltools httr
NULL

#' Sets up scripts needed for Learning Locker API
#'
#' @param session The current R session
#' @param config Endpoint configuration
#'
#' @return HTTP Status Code
#'
#' @export
connect <- function(session, config) {

  # Append xapiwrapper to DOM head
  insertUI(
    selector = "head",
    where = "beforeEnd",
    ui = htmltools::attachDependencies(htmltools::tags$head(), dep, append = TRUE),
    immediate = TRUE,
    session = getDefaultReactiveDomain()
  )

  set_locker_config(config)

  # Pass locker configuration to begin connection
  session$sendCustomMessage("rLocker-setup", config)

  # Connection details
  connection <- list(status = test(), agent = config$agent)

  # Make note of when the connection was set
  comment(connection) <- paste(Sys.time())

  # Return connection
  return(connection)
}

#' Simple function to check if connection succeeds
#'
#' @param config Endpoint configuration
#'
#' @export
test <- function(config = get_locker_config()) {

  status <- NULL

  # Check to see if auth token is set or if username and password are set instead.
  if (is.null(config$auth) & (is.null(config$user) | is.null(config$pass))) {
    warning("Locker credentials are not set; unable to proceed with test.")
  } else {
    # Try making a connection to the endpoint
    tryCatch({

      response <- httr::with_config(config(), GET(
        httr::modify_url(config$base_url, path = "api/connection/statement"),
      ))

      status <- httr::status_code(response)

      #' @details https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html
      if (status != 200) {
        message(paste0("Unable to connect to xAPI endpoint. ", http_status(status)$message), ".")
      }
    },
    error = function(cond) {
      message(cond)
      return(NA)
    },
    warning = function(cond) {
      message(cond)
      return(NULL)
    })
  }

  return(status)
}
