#'statement
#'
#'Contains test data for now.
#'@import jsonlite

#'@export
createActor <- function(x = NULL, warn = TRUE, ...) {
  params <- x

  if(is.null(params$actor) & warn){
    warning('No actor arguments specified; using default xapi:actor.', call. = FALSE)
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

#'@export
createResult <- function(x = NULL, warn = TRUE, ...) {
  params <- x

  if(is.null(params$result) & warn){
    warning('No object arguments specified; using default xapi:result', call. = FALSE)
  }

  # Set defaults
  success = ifelse(is.null(params$result$success), FALSE, params$result$success)
  response = ifelse(is.null(params$result$response), "answer", params$result$response)

  obj <- list(
    success = success,
    response = response
  )

  return(obj)
}

#'@export
createStatement <- function(x = NULL, warn = TRUE, ...) {
  params <- x

  print(typeof(params$object))
  
  if(is.null(params)){
    warning('No arguments specified; using default xapi:statement.', call. = FALSE)
    warn = FALSE
  }

  # todo: check if verb requires a result object

  statement <- list(
    actor = createActor(list(actor = params$actor), warn),
    verb = do.call(createVerb, list(params$verb)),
    object = do.call(createObject, c(params$object, warn = warn)),
    result = createResult(list(result = params$result), warn)
  )

  return(toJSON(statement, pretty = TRUE, auto_unbox = TRUE))
}
