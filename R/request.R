#' Storage and retrieval mechanisms for Learning Locker API
#'
#' @name request
NULL

#' Stores an xAPI Statement in configured locker
#' 
#' @param session Shiny session
#' @param statement xAPI Statement
#' @param warn Show warnings
#' 
#' @seealso \code{\link{connect}}
#' @seealso \code{\link{retrieve}}
#' @seealso \code{\link{createStatement}}
#' 
#' @return HTTP Status
#' 
#' @note Requires interactive session
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

#' Makes a simple HTTP GET request to Learning Locker API
#' @seealso \link{https://docs.learninglocker.net/http-statements/}
#' 
#' @param interface HTTP \code{\link{Interface}}
#' @param model API \code{\link{Model}}
#' @param query (optional) Filter 
#' @param asJSON (optional) Return content as json string
#' 
#' @return response content
#' 
#' @examples
#' retrieve(interface = "rest", model = "lrs")
#' retrieve(interface = "connection", model = "statement", query = "first=1", asJSON = TRUE)
#' retrieve(interface = "connection", model = "statement", query = "?sort=%7b%22timestamp%22%3a-1%2c%22statement.id%22%3a1%7d", asJSON = TRUE)
#' 
#' @export
retrieve <- function(interface = NULL, model = NULL, query = NULL, asJSON = FALSE) {

  tryCatch({

    config <- get_locker_config()

    if (is.null(config)) {
      stop("Unable to process request; locker config not set.")
    }

    model_id      <- model
    model         <- getModel(model_id)
    interface_id  <- interface
    interface     <- getInterface(interface_id)

    if (is.null(model) || class(model) != "model") {
      stop("Unable to process request; api model not specified or is invalid.")
    }

    if (is.null(interface) || class(interface) != "interface") {
      stop("Unable to process request; api interface not specified or is invalid.")
    }

    request <- if (interface_id == "rest") {
      httr::modify_url(
        config$base_url,
        path = paste0(interface$route, model_id, ifelse(!is.null(query), paste0("/", query), ""))
      )
    } else {
      httr::modify_url(
        config$base_url,
        path = paste0(interface$route, model_id),
        query = query
      )
    }

    response <- with_config(config(), GET(request))

    status <- response$status

    content <- httr::content(response)

    #' @details \link{https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html}
    if (status != 200) {
      message(
        paste(
          status, 
          stringr::str_squish(
            stringr::str_trim(gsub("<.*?>|\n", " ", content(response, as = "text")), side = "both")
          )
        )
      )

      content <- NA
    } else {
      if (asJSON) {
        content <- formatJSON(content)
      }
    }

    return(content)
  })
}