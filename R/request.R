#'request
#'
#' @name request
NULL

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
retrieve <- function(model = NULL, interface = "connection", query, asJSON = FALSE){
  
  # @todo if interface == connection, query belongs as html encoded + json encoded ?queryString
  #       else query belongs after the model
  
  tryCatch({
    if(is.null(model) || getModel(model) == -1){
      stop("Unable to process request; api model not specified or is invalid.")
    }
    
    config <- get_locker_config()
    
    interface <- getInterface(interface)
    
    request <- modify_url(
      config$base_url,
      path = paste(interface$route, model, sep = "/"),
      query = query
    )
    
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
    
  })
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