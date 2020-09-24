#'actor
#'
#' xAPI Actor object definitions
#'
#' @name actor
#' @section Description:
#'   The Actor defines who performed the action. The Actor of a Statement can be an Agent or a Group.
#' @seealso \link{https://github.com/adlnet/xAPI-Spec/blob/master/xAPI-Data.md#actor}
NULL

#' createActor
#' 
#' @param agent Agent params
#' @param group Group params
#' @param warn Show warnings
#' 
#' @return Actor
#' 
#'@export
createActor <- function(
  agent = NULL,
  group = NULL,
  warn = FALSE, ...) {

  obj <- list()

  if (!is.null(agent) | is.null(group)) {
    obj <- do.call(createAgent, list(agent = agent, warn = warn))
  } else {
    obj <- do.call(createGroup, list(group = group, warn = warn))
  }

  class(obj) <- "Actor"

  return(obj)
}

#' getActorDefinition
#' 
#' Returns an empty Actor object with possible arguments.
#' 
#' @return definition
#' 
#'@export
getActorDefinition <- function() {
  definition <- list(
    mbox = NA_character_,
    mbox_sha1sum = NA_character_,
    account = list(
      name = NA_character_,
      homePage = NA_character_
    ),
    name = NA_character_,
    member = NA_character_,
    openid = NA_character_,
    objectType = NA_character_
  )

  return(definition)
}

#' getActorTypes
#' 
#' Returns a list of possible Actor types.
#' 
#' @return list
#' 
#'@export
getActorTypes <- function() {
  return(actorTypes)
}

actorTypes <- c(
  "Agent",
  "Group"
)