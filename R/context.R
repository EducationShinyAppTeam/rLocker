#'context
#'
#' xAPI Context object definitions
#' 
#' @name context
#' @section Details:
#'   An optional property that provides a place to add contextual information to a Statement.
#' @seealso \link{https://github.com/adlnet/xAPI-Spec/blob/master/xAPI-Data.md#context}
NULL

#'@export
createContext <- function(
  context = NULL,
  warn = FALSE, ...) {

  if (is.null(context) & warn) {
    warning("Context arguments not specified; using default xapi:context", call. = FALSE)
  }

  # Set defaults
  objectType <- ifelse(is.null(object$type), NA, object$type)

  obj <- list()

  if (!is.null(context$registration)) {
    # todo: check if matches uuid pattern
    obj$registration <- context$registration
  }

  if (!is.null(context$instructor)) {
    # todo: check if object is an Agent or Group
    obj$instructor <- do.call(createAgent, list(agent = context$instructor, warn = warn))
  }

  if (!is.null(context$team)) {
    # todo: check if object is an Group
    obj$team <- context$team
  }

  if (!is.null(context$contextActivities)) {
    # todo: check if object is a contextActivity
    obj$contextActivity <- context$contextActivity
  }

  if (!is.null(context$revision) & objectType == "Activity") {
    obj$revision <- context$revision
  }

  if (!is.null(context$platform) & objectType == "Activity") {
    obj$platform <- context$platform
  }

  if (!is.null(context$language)) {
    # todo: check if matches language tag e.g. 'en-US'
    obj$language <- context$language
  }

  if (!is.null(context$statement)) {
    # todo: check if object is a statement reference
    obj$statement <- context$statement
  }

  if (!is.null(extensions)) {
    obj$extensions <- do.call(createExtension, list(extension = context$extensions, warn = warn))
  }

  # Object is empty 
  if (!length(obj)) {
    obj <- NA
  }
  
  class(obj) <- "Context"

  return(obj)
}

#'@export
getContextDefinition <- function() {
  definition <- list(
    registration = NA_character_,
    instructor = NA_character_,
    team = NA_character_,
    contextActivities = NA_character_,
    revision = NA_character_,
    platform = NA_character_,
    language = NA_character_,
    statement = NA,
    extensions = NA
  )
  return(definition)
}