#'connect
#'
#'Tests Learning Locker API Configuration
#'
#'@param config API Configuration
#'@return HTTP Status Code
#'@import htmltools httr
#'@export
test <- function(config) {

  # Check to see if auth token is set or if username and password are set instead.
  if(is.null(config$auth) & (is.null(config$user) | is.null(config$pass))){
    warning("Locker credentials are not set; unable to proceed with test.")
  } else {
    # Try making a connection to the endpoint
    tryCatch({

      # Todo check if endpoint has data/xapi
      status <- status_code(GET(paste(c(config$endpoint, "/about"), collapse="")))

      #'@details https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html
      if(!status == 200){
        warning(paste(c("Unable to connect to xAPI endpoint.\n\tReason: ", http_status(status)$message)))
      }
    },
    error = function(e){
      stop(e$message)
    })
  }

  return(status)
}

#'Sets up scripts needed for Learning Locker API
#'
#'@param session The current R session
#'@param config API Configuration
#'@return HTTP Status Code
#'@export
connect <- function(session, config) {

  # Append xapiwrapper to DOM head
  insertUI(
    selector = "head",
    where = "beforeEnd",
    ui = htmltools::attachDependencies(htmltools::tags$head(), dep, append = TRUE),
    immediate = TRUE,
    session = getDefaultReactiveDomain()
  )

  # Pass locker configuration to begin connection
  session$sendCustomMessage("rlocker-setup", config)

  # Test the config and return the results
  return(test(config))
}
