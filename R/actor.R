#'actor
#' 
#' xAPI Actor object definitions

#'@export
getActorDefinition <- function() {
  actor <- list(
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
  
  return(actor)
}

#'@export
getActorTypes <- function() {
  types <- c(
    "Agent",
    "Group"
  )
  return(types)
}