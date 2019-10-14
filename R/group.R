#'group
#'
#' xAPI Group object definitions
#' 
#' @name group
#' @section Description:
#'   A Group represents a collection of Agents and can be used in most of the same situations an Agent can be used. There are two types of Groups: Anonymous Groups and Identified Groups.
#' @section Details:
#'   An Identified Group is used to uniquely identify a cluster of Agents whereas an Anonymous Group is used to describe a cluster of people where there is no ready identifier for this cluster, e.g. an ad hoc team.
#' @seealso \link{https://github.com/adlnet/xAPI-Spec/blob/master/xAPI-Data.md#group}
NULL

#' Create an xAPI Group
#' 
#' @section Description:
#'   Shorthand method to create Group
#' 
#' @param name Name of the Group.
#' ### FINISH ADDING PARAMS ###
#' ### FINISH ADDING PARAMS ###
#' ### FINISH ADDING PARAMS ###
#' ### FINISH ADDING PARAMS ###
#' ### FINISH ADDING PARAMS ###
#' @param members The members of this Group.
#' 
#' @seealso \code{\link{agent}}
#' @seealso \code{\link{createGroup}}
#' 
#' @export
group <- function(...){
  #return(
   # createGroup(
    #  group = list(members = ...)
    #)
  #)
  params = list(...)

  return(params)
}

#' @export
members <- function(...){
  return(createGroupMembers(members = list(...)))
}

#' Creates an xAPI Group object
#' 
#' @param group Group params
#' @param warn Show warnings
#' 
#' @seealso \code{\link{group}}
#' 
#' @return xAPI Group object
#' 
#' @examples
#' createGroup(
#'   group = list(
#'     name = "RTeam",
#'     members = list(
#'       agent(name = "Bob", mbox = "mailto:bob@example.com"),
#'       agent(name = "Kathy", mbox = "mailto:kathy@example.com"),
#'       agent(name = "Tom", mbox = "mailto:tom@example.com")
#'     )
#'   )
#' )
#' 
#' @export
createGroup <- function(
  group = NULL,
  warn = FALSE, ...) {

  obj <- list()
  
  if(!is.null(group$name)){
    obj$name <- group$name
  }
  
  if (!is.null(group$email) & is.null(group$mbox)) {
    obj$mbox = mailto(group$email)
  }
  
  obj$member <- createGroupMembers(group$members)
  
  class(obj) <- "Group"
  obj$objectType <- class(obj)
  
  return(obj)
}

#' @export
createGroupMembers <- function(members){
  
  obj <- list()
  
  for (member in members) {
    if(class(member) != "Agent"){
      agent <- createAgent(member)
    } else {
      agent <- member
    }
    obj <- c(obj, list(agent))
  }
  
  return(obj)
}
