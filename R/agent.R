#' agent
#' 
#' xAPI Agent object definitions

#'@export
getAgentDefinition <- function() {
  agent <- list(
    account = list(
      name = "",
      homePage = ""
    ),
    group_members = "",
    mbox = "",
    name = "", 
    objectType = "",
    openid = ""
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