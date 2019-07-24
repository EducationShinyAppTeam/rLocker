#' statement
#' 
#' xAPI Statement object creation functions
#' @importFrom uuid UUIDgenerate
#' @name statement
NULL

#' Creates an xAPI Agent object
#' 
#' @param agent Agent defaults
#' @param warn Show warnings
#' 
#' @seealso \code{\link{agent}}
#' 
#' @return xAPI Agent object
#' 
#' @examples
#' createAgent(agent = list(name = "John Doe", mbox = "mailto:john@example.com"))
#' 
#' @export
createAgent <- function(
  agent = NULL,
  warn = FALSE, ...) {
  
  if(is.null(agent) & warn){
    warning('Agent arguments not specified; using default xapi:agent.', call. = FALSE)
  }
  
  obj <- list(
    name = ifelse(is.null(agent$name), uuid::UUIDgenerate(), agent$name),
    mbox = ifelse(is.null(agent$mbox), "mailto:test@example.org", agent$mbox),
    objectType = ifelse(is.null(agent$objectType), "Agent", agent$objectType)
  )

  return(obj)
}

#' Creates an xAPI Verb object
#' 
#' @param verb Verb name
#' @param id URI to verb definition
#' @param warn Show warnings
#' 
#' @seealso \code{\link{verbs}}
#' 
#' @return xAPI Verb object
#' 
#' @examples
#' createVerb(verb = list(display = "custom-verb", id = "https://example.com/xapi/verbs/custom-verb"))
#' 
#' @export
createVerb <- function(
  verb = NULL,
  warn = FALSE, ...) {
  
  if(is.null(verb) & warn){
    warning('Verb arguments not specified; using default xapi:verb.', call. = FALSE)
  }

  # Set defaults
  display = ifelse(is.null(verb$display), 'experienced', verb$display)
  id = ifelse(is.null(verb$id), paste(c("http://adlnet.gov/expapi/verbs/", verb$display), collapse = ""), verb$id)

  # todo: add lookup from verbs list
  # todo: add language support
  # todo: warn - id should be a valid url

  obj <- list(
    id = id,
    display = list(
      "en-US" = display
    )
  )

  return(obj)
}

#' Creates an xAPI Object object
#' 
#' @param name Object name
#' @param description Brief description of the object
#' @param id URI to object or activity
#' @param warn Show warnings
#' 
#' @return xAPI Object object
#' 
#' @examples
#' createObject(object = list(name = "Question 1", description = "Example question description."))
#' 
#' @export
createObject <- function(
  object = NULL,
  warn = FALSE, ...) {

  if(is.null(object) & warn){
    warning('Object arguments not specified; using default xapi:object.', call. = FALSE)
  }

  # Set defaults
  id <- ifelse(is.null(object$id), "http://adlnet.gov/expapi/activities/example", object$id)
  name <- ifelse(is.null(object$name), "Example Activity", object$name)
  description <- ifelse(is.null(object$description), "Example activity description", object$description)

  obj <- list(
    id = id,
    definition = list(
      name = list(
        "en-US" = name
      ),
      description = list(
        "en-US" = description
      )
    )
  )

  return(obj)
}

#' Creates an xAPI Result object
#' 
#' @param success Holds a value if interaction can be marked as successful/unsuccessful.
#' @param response Response from the user on a given action
#' @param warn Show warnings
#' 
#' @seealso \code{\link{result}}
#' 
#' @return xAPI Result object
#' 
#' @examples
#' createResult(result = list(success = TRUE, response = "correctAnswer"))
#' 
#' @export
createResult <- function(
  result = NULL,
  warn = FALSE, ...) {

  if(is.null(result) & warn){
    warning('Result arguments not specified; using default xapi:result', call. = FALSE)
  }

  # Set defaults
  success = ifelse(is.null(result$success), NA, result$success)
  response = ifelse(is.null(result$response), "DEFAULT_RESPONSE", result$response)

  obj <- list(
    success = success,
    response = response
  )

  return(obj)
}

#' Creates an xAPI Extension object
#' 
#' @param ref Internationalized resource identifier (uri extension)
#' @param value Any value matching corresponding reference definition constraints
#' 
#' @seealso \code{\link{result}}
#' 
#' @return xAPI Result object
#' 
#' @examples
#' createExtension(extension = list(ref = "https://w3id.org/xapi/cmi5/result/extensions/progress", value = 100))
#' 
#' @export
createExtension <- function(
  extension = NULL,
  warn = FALSE, ...) {
  
  if(is.null(extension) & warn){
    warning('Extension arguments not specified; using default xapi:extension', call. = FALSE)
  }
  
  # Set defaults
  dfn <- getExtensionDefinition()
  
  ref = ifelse(is.null(extension$ref), dfn$ref, extension$ref)
  value = ifelse(is.null(extension$value), dfn$value, extension$value)
  
  obj <- list(
    ref = ref,
    value = value
  )
  
  return(obj)
}

#' Creates an xAPI Statement
#' 
#' @param x Statement values
#' @param warn Show warnings
#' 
#' @seealso \code{\link{createAgent}}
#' @seealso \code{\link{createVerb}}
#' @seealso \code{\link{createObject}}
#' @seealso \code{\link{createResult}}
#' 
#' @return xAPI Statement (json)
#' 
#' @export
createStatement <- function(x = NULL, warn = FALSE, ...) {
  params <- x
  
  if(is.null(params)){
    warning('No arguments specified; using default xapi:statement.', call. = FALSE)
    warn = FALSE
  }
  
  # todo: check if verb requires a result object

  statement <- list(
    agent = do.call(createAgent, list(agent = params$agent, warn = warn)),
    verb = do.call(createVerb, list(verb = params$verb, warn = warn)),
    object = do.call(createObject, list(object = params$object, warn = warn)),
    result = do.call(createResult, list(result = params$result, warn = warn))
  )

  return(formatJSON(statement, pretty = TRUE, auto_unbox = TRUE))
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
  
  # Return HTTP STATUS 200 - OK
  # todo: listen for actual status updates
  return(200)
}