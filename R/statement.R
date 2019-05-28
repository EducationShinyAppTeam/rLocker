#' statement
#' 
#' xAPI Statement object creation functions
#' @importFrom uuid UUIDgenerate
NULL

#' Creates an xAPI Actor object
#' 
#' @param actor Actor defaults
#' @param warn Show warnings
#' 
#' @seealso \code{\link{actor}}
#' 
#' @return xAPI Actor object
#' 
#' @examples
#' createActor(name = "John Doe", mbox = "mailto:john@example.com")
#' 
#' @export
createActor <- function(
  actor = NULL,
  warn = TRUE, ...) {
  
  if(is.null(actor) & warn){
    warning('Actor arguments not specified; using default xapi:actor.', call. = FALSE)
  }
  
  obj <- list(
    name = ifelse(is.null(actor$name), uuid::UUIDgenerate(), actor$name),
    mbox = ifelse(is.null(actor$mbox), "mailto:test@example.org", actor$mbox),
    objectType = ifelse(is.null(actor$objectType), "Actor", actor$objectType)
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
#' createVerb(verb = "experienced")
#' createVerb(verb = "custom-verb", id = "https://example.com/xapi/verbs/custom-verb")
#' 
#' @export
createVerb <- function(
  verb = NULL,
  id = NULL,
  warn = TRUE, ...) {
  
  if(is.null(verb) & warn){
    warning('Verb arguments not specified; using default xapi:verb.', call. = FALSE)
  }

  # Set defaults
  verb = ifelse(is.null(verb), 'experienced', verb)
  id = ifelse(is.null(id), paste(c("http://adlnet.gov/expapi/verbs/", verb), collapse=""), id)

  # todo: add lookup from verbs list
  # todo: add language support
  # todo: warn - id should be a valid url

  obj <- list(
    id = id,
    display = list(
      "en-US" = verb
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
#' createObject(name = "Question 1", description = "Example question description.")
#' createObject(name = question$title, description = question$description, id = session$clientData)
#' 
#' @export
createObject <- function(
  object = NULL,
  warn = TRUE, ...) {

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
#' createResult(success = TRUE, response = "correctAnswer")
#' 
#' @export
createResult <- function(
  result = NULL,
  warn = TRUE, ...) {

  if(is.null(result) & warn){
    warning('Result arguments not specified; using default xapi:result', call. = FALSE)
  }

  # Set defaults
  success = ifelse(is.null(result$success), FALSE, result$success)
  response = ifelse(is.null(result$response), "DEFAULT_RESPONSE", result$response)

  obj <- list(
    success = success,
    response = response
  )

  return(obj)
}

#' Creates an xAPI Statement
#' 
#' @param x Statement values
#' @param warn Show warnings
#' 
#' @seealso \code{\link{createActor}}
#' @seealso \code{\link{createVerb}}
#' @seealso \code{\link{createObject}}
#' @seealso \code{\link{createResult}}
#' 
#' @return xAPI Statement (json)
#' 
#' @examples
#' createStatement(success = TRUE, response = "correctAnswer")
#' 
#' @export
createStatement <- function(x = NULL, warn = TRUE, ...) {
  params <- x
  
  if(is.null(params)){
    warning('No arguments specified; using default xapi:statement.', call. = FALSE)
    warn = FALSE
  }
  
  # todo: check if verb requires a result object

  statement <- list(
    actor = do.call(createActor, list(actor = params$actor, warn)),
    verb = do.call(createVerb, list(verb = params$verb, warn)),
    object = do.call(createObject, list(object = params$object, warn)),
    result = do.call(createResult, list(result = params$result, warn))
  )

  return(formatJSON(statement, pretty = TRUE, auto_unbox = TRUE))
}
