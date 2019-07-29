#' agent
#' 
#' xAPI Agent object definitions

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