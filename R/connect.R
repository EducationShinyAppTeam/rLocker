#' connect
#' 
#' @import htmltools httr

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
  
  set_config(
    add_headers(
      Authorization = config$auth
    )
  )
  
  # Pass locker configuration to begin connection
  session$sendCustomMessage("rlocker-setup", config)
  
  # Connection details
  connection <- list(status = test(config), agent = config$agent)
  
  # Return connection
  return(connection)
}

#' @export
test <- function(cfg) {
  
  status <- NULL
  
  # Check to see if auth token is set or if username and password are set instead.
  # is.null(config$auth) & (is.null(config$user) | is.null(config$pass))
  if (FALSE) {
    warning("Locker credentials are not set; unable to proceed with test.")
  } else {
    # Try making a connection to the endpoint
    tryCatch({
      
      response <- with_config(config(), GET(
        paste0(cfg$base_url, "api/connection/statement"),
      ))
      
      status <- status_code(response)
      
      #' @details https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html
      if (status != 200) {
        message(paste0("Unable to connect to xAPI endpoint. ", http_status(status)$message), ".")
      }
    },
    error = function(cond){
      message(cond)
      return(NA)
    },
    warning = function(cond){
      message(cond)
      return(NULL)
    })
  }
  
  return(status)
}

#' Makes a simple HTTP GET request to Learning Locker API endpoint
#' Uses HTTP Connection Interface
#' @seealso \link{https://docs.learninglocker.net/http-statements/}
#' 
#' ### ### ### ### ### ### ### ### ### THESE NEED TO BE UPDATED ### ### ### ### ### ### ### ### ###
#' Should this be renamed to retrieve as we're only making get requests? api_retrieve rlocker::retrieve
#' api/connection should be added to the base request automatically, we're not supporting REST at this time
#' base_url + "api/connection" + request_type + query
#' create new functions for connection details set_locker_config() / get_locker_config() (there's a collision with set_config in httr)
#' 
#' @param session The current R session
#' @param request API request string
#' @param asJSON (optional) Return content as json string
#' 
#' @return response content
#' 
#' @export
retrieve <- function(model, interface = "connection", query, asJSON = FALSE){
  
  # @todo if interface == connection, query belongs as html encoded + json encoded ?queryString
  #       else query belongs after the model
  # @todo create a method to return available model names
  request <- paste(get_locker_config()$base_url, "api", interface, model, query, sep = "/")
  
  response <- with_config(config(), GET(request))
  
  status <- response$status
  
  content <- httr::content(response)
  
  #' @details https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html
  if (status != 200) {
    message(
      paste(status, 
        stringr::str_squish(
          stringr::str_trim(gsub("<.*?>|\n", " ", content(response, as = "text")), side = "both")
        )
      )
    )
    
    content <- NA
  } else {
    if(asJSON){
      content <- formatJSON(content)
    }
  }
  
  return(content)
}

#' Stores an xAPI Statement
#' 
#' @param statement xAPI Statement
#' @param warn Show warnings
#' 
#' @seealso \code{\link{createStatement}}
#' 
#' @return HTTP Status
#' 
#' @export
store <- function(session, statement = NULL, warn = FALSE, ...) {
  # Pass the statement to the js handler
  session$sendCustomMessage("rlocker-store", statement)
  
  # HTTP Status Code
  status_code <- ifelse(!is.null(session$input$storageStatus), session$input$storageStatus, 502)
  
  # Return HTTP_STATUS
  return(status_code)
}
