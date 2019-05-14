#'statement
#'
#'Contains test data for now.
#'@import jsonlite

#' Creates an xAPI Actor object
#' 
#' @param actor Current user
#' @param type Type of actor
#' @param warn Show warnings
#' 
#' @return xAPI Actor object
#' 
#' @examples
#' createActor(type = "Agent")
#' 
#' @export
createActor <- function(actor = NULL, type = NULL, warn = TRUE, ...) {
  
  actor = ifelse(is.null(actor), list(name = "", email = ""), verb)
  
  if(is.null(actor) & warn){
    warning('Actor arguments not specified; using default xapi:actor.', call. = FALSE)
  }

  obj <- list(
    objectType = "Agent"
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
  name = NULL,
  description = NULL,
  id = NULL,
  warn = TRUE, ...) {

  if(is.null(name) & is.null(description) & warn){
    warning('Object arguments not specified; using default xapi:object.', call. = FALSE)
  }

  # Set defaults
  id = ifelse(is.null(id), "http://adlnet.gov/expapi/activities/example", id)
  name = ifelse(is.null(name), "Example Activity", name)
  description = ifelse(is.null(description), "Example activity description", description)

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
#' @return xAPI Result object
#' 
#' @examples
#' createResult(success = TRUE, response = "correctAnswer")
#' 
#' @export
createResult <- function(
  success = NULL,
  response = NULL,
  warn = TRUE, ...) {
  params <- x

  if(is.null(result) & warn){
    warning('Result arguments not specified; using default xapi:result', call. = FALSE)
  }

  # Set defaults
  success = ifelse(is.null(result$success), FALSE, result$success)
  response = ifelse(is.null(result$response), "answer", result$response)

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
    actor = createActor(list(actor = params$actor), warn),
    verb = do.call(createVerb, c(params$verb, warn = warn)),
    object = do.call(createObject, c(params$object, warn = warn)),
    result = createResult(list(result = params$result), warn)
  )

  return(toJSON(statement, pretty = TRUE, auto_unbox = TRUE))
}
