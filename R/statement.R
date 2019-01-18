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

#'@export
createVerb <- function(x = NULL, warn = TRUE, ...) {
  params <- x

  if(is.null(params$verb) & warn){
    warning('No verb arguments specified; using default xapi:verb.', call. = FALSE)
  }

  # Set defaults
  verb = ifelse(is.null(params$verb), 'experienced', params$verb)
  id = ifelse(is.null(params$id), paste(c("http://adlnet.gov/expapi/verbs/", verb), collapse=""), params$id)

  # todo: add lookup from verbs list
  # todo: add language support

  obj <- list(
    id = id,
    display = list(
      "en-US" = verb
    )
  )

  return(obj)
}

#'@export
createObject <- function(x = NULL, warn = TRUE, ...) {
  params <- x

  if(is.null(params$object) & warn){
    warning('No object arguments specified; using default xapi:object.', call. = FALSE)
  }

  # Set defaults
  id = ifelse(is.null(params$result$success), FALSE, params$result$success)
  name = ifelse(is.null(params$result$response), "answer", params$result$response)
  description = ifelse(is.null(params$result$response), "answer", params$result$response)

  obj <- list(
    id = "http://adlnet.gov/expapi/activities/example",
    definition = list(
      name = list(
        "en-US" = "Example Activity"
      ),
      description = list(
        "en-US" = "Example activity description"
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

  if(is.null(params)){
    warning('No arguments specified; using default xapi:statement.', call. = FALSE)
    warn = FALSE
  }

  # todo: check if verb requires a result object

  statement <- list(
    actor = createActor(list(actor = params$actor), warn),
    verb = createVerb(list(verb = params$verb), warn),
    object = createObject(list(object = params$object), warn),
    result = createResult(list(result = params$result), warn)
  )

  return(toJSON(statement, pretty = TRUE, auto_unbox = TRUE))
}
