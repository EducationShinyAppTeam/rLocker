#' Interface
#'
#' @description Learning Locker API Interface
#'
#' @name Interface
#'
#' @seealso \link{https://docs.learninglocker.net/http-rest/}

#' getInterfaceList
#' 
#' Returns a vector of the Learning Locker API Interface types.
#' 
#' @return vector
#' 
#'@export
getInterfaceList <- function() {
  return(names(interfaces))
}

#' getInterface
#' 
#' Returns details about a specific Learning Locker API Interface.
#' 
#' @param name Interface name
#' @param asJSON Return as json
#' 
#' @name Interface
#' 
#' @return Interface
#' 
#' @export
getInterface <- function(name, asJSON = FALSE) {
  exists <- exists(name, interfaces)

  if (exists & asJSON) {
    return(formatJSON(interfaces[[name]]))
  } else if (exists) {
    return(
      structure(
        interfaces[[name]],
        class = "interface"
      )
    )
  } else {
    return(-1)
  }
}

interfaces <- list(
  "rest" = list(
    "name" = "REST API HTTP Interface",
    "description" = "This HTTP interface is available for all models in Learning Locker.",
    "route" = "api/v2/"
  ),
  "connection" = list(
    "name" = "Connection HTTP Interface",
    "description" = "The Learning Locker Connection API is a HTTP interface that utilises cursors to provide paginated models inspired by GraphQL's connections. The API is available for all models in Learning Locker.",
    "route" = "api/connection/"
  ),
  "aggregation" = list(
    "name" = "Aggregation HTTP Interface",
    "description" = "The Learning Locker Aggregation HTTP interface utilises the Mongo aggregation API and is only available for statements.",
    "route" = "api/statements/aggregate"
  )
  # "statement_deletion" = list(
  #   "name" = "Statement Deletion HTTP Interface",
  #   "description" = "Statements may be deleted individually, using the record’s _id, or in bulk via a batch delete method.",
  #   "route" = "api/v2/statement/"
  # ),
  # "statement_batch_deletion" = list(
  #   "name" = "Statement Batch Deletion HTTP Interface",
  #   "description" = "Statements may be deleted individually, using the record’s _id, or in bulk via a batch delete method.",
  #   "route" = "api/v2/batchdelete/"
  # )
)