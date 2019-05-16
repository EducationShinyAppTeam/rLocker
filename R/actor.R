#'actor
#'
#'@import uuid
NULL

Actor <- setClass("Actor", 
   slots = c(
     account = list(
       name = "character",
       homePage = "character"
     ),
     group_members = "character",
     mbox = "character",
     name = "character", 
     objectType = "character",
     openid = "character"
   ), 
   prototype = list(
     objectType = "Agent",
     name = uuid::UUIDgenerate(),
     mbox = "mailto:test@example.org"
   )
)

Actor.getActorTypes = function() {
  types <- c(
    "Agent",
    "Group"
  )
  return(types)
}