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

#'@export
createGroup <- function(
  group = NULL,
  warn = FALSE, ...) {

}