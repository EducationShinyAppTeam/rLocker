#' agent
#' 
#' xAPI Agent object definitions

#' Creates an xAPI Agent object
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

#'@export
getAgentDefinition <- function() {
  agent <- list(
    account = list(
      name = NA_character_,
      homePage = NA_character_
    ),
    group_members = NA_character_,
    mbox = NA_character_,
    name = NA_character_, 
    objectType = NA_character_,
    openid = NA_character_
  )
  
  return(agent)
}

#'@export
getAgentTypes <- function() {
  types <- c(
    "Agent",
    "Group"
  )
  return(types)
}