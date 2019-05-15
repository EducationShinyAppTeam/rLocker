#'actor
#'@import uuid
NULL

# Actor class definition
Actor <- R6Class("Actor", 
  public = list(
    initialize = function(...) {
      x <- list(...)
      
      # Set required defaults
      private$objectType <- ifelse(is.null(x$type), "Agent", x$type)
      private$name <- ifelse(is.null(x$name), UUIDgenerate(), x$name)
      private$mbox <- ifelse(is.null(x$mbox), "mailto:test@example.org", x$mbox)
    }
  ),
  private = list(
    account = list(
      name = NULL,
      homePage = NULL
    ),
    objectType = NULL,
    name = NULL,
    mbox = NULL,
    mbox_sha1sum = NULL,
    openid = NULL,
    group_members = NULL
  )
)

Actor.getActorTypes = function(){
  types <- c(
    "Agent",
    "Group"
  )
  return(types)
}
