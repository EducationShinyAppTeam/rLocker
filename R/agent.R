#' agent
#' 
#' xAPI Agent object definitions
#' 
#' @name agent
#' @section Description:
#'  An Agent (an individual) is a persona or system.
NULL

#' Create an xAPI Agent
#' 
#' @section Description:
#'   Shorthand method to create Agent
#' 
#' @param email Only email addresses that have only ever been and will ever be assigned to this Agent, but no others, SHOULD be used for this property, mbox, and mbox_sha1sum.
#' @param mbox The required format is "mailto:email address".
#' @param mbox_sha1sum The hex-encoded SHA1 hash of a mailto IRI (i.e. the value of an mbox property).
#' @param account A user account Object on an existing system e.g. an LMS or intranet.
#' @param name Full name of the Agent.
#' @param openid An openID that uniquely identifies the Agent.
#' 
#' @seealso \code{\link{createAgent}}
#' 
#' @export
agent <- function(...) {
  return(createAgent(agent = list(...)))
}

#' Create an xAPI Agent
#' 
#' @param agent Agent defaults
#' @param warn Show warnings
#' 
#' @seealso \code{agent}
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

  if (is.null(agent) & warn) {
    warning("Agent arguments not specified; using default xapi:agent.", call. = FALSE)
  }
  
  if (!is.null(agent$email) & is.null(agent$mbox)) {
    agent$mbox <- mailto(agent$email)
  }

  obj <- list(
    name = ifelse(is.null(agent$name), uuid::UUIDgenerate(), agent$name),
    mbox = ifelse(is.null(agent$mbox), "mailto:test@example.org", agent$mbox),
    objectType = ifelse(is.null(agent$objectType), "Agent", agent$objectType)
  )
  
  class(obj) <- "Agent"

  return(obj)
}

#'@export
getAgentDefinition <- function() {
  definition <- list(
    mbox = NA_character_,
    mbox_sha1sum = NA_character_,
    account = list(
      name = NA_character_,
      homePage = NA_character_
    ),
    name = NA_character_,
    openid = NA_character_,
    objectType = NA_character_
  )

  return(definition)
}