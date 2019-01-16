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

  actor <- list(
    objectType = "Agent"
  )

  return(actor)
}

#'@export
createVerb <- function(x = NULL, warn = TRUE, ...) {
  params <- x

  if(is.null(params$verb) & warn){
    warning('No verb arguments specified; using default xapi:verb.', call. = FALSE)
  }

  # Set defaults
  verb = ifelse(is.null(params$verb), 'experienced' , params$verb)
  id = ifelse(is.null(params$id), paste(c("http://adlnet.gov/expapi/verbs/", verb), collapse=""), params$id)

  # todo add lookup from verbs list

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

  object <- list(
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

  return(object)
}

#'@export
createStatement <- function(x = NULL, warn = TRUE, ...) {
  params <- x

  if(is.null(params)){
    warning('No arguments specified; using default xapi:statement.', call. = FALSE)
    warn = FALSE
  }

  statement <- list(
    actor = createActor(list(actor = params$actor), warn),
    verb = createVerb(list(verb = params$verb), warn),
    object = createObject(list(object = params$object), warn)
  )

  return(toJSON(statement, pretty = TRUE, auto_unbox = TRUE))
}

#'@export
getVerbList <- function() {
  return(names(verbs))
}

#'@export
getVerb <- function(name, asJSON = FALSE) {
  exists = exists(name, verbs)

  if(exists & asJSON) {
    return(formatJSON(verbs[name]))
  } else if(exists) {
    return(verbs[name])
  } else {
    return(-1)
  }
}

#'@export
formatJSON <- function(json) {
  return(toJSON(json, pretty = TRUE, auto_unbox = TRUE))
}

