#' interface
#' 
#' Learning Locker API interfaces
#' @seealso \link{https://docs.learninglocker.net/http-rest/}

#'@export
getInterfaceList <- function() {
  return(names(interfaces))
}

#'@export
getInterface <- function(name, asJSON = FALSE) {
  exists <- exists(name, interfaces)
  
  if (exists & asJSON) {
    return(formatJSON(interfaces[[name]]))
  } else if(exists) {
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
    "route" = "connection/"
  ),
  "aggregation" = list(
    "name" = "Aggregation HTTP Interface",
    "description" = "The Learning Locker Aggregation HTTP interface utilises the Mongo aggregation API and is only available for statements.",
    "route" = "statements/aggregate"
  )
  # "statement_deletion" = list(
  #   "name" = "Statement Deletion HTTP Interface",
  #   "description" = "Statements may be deleted individually, using the record’s _id, or in bulk via a batch delete method.",
  #   "route" = "v2/statement/"
  # ),
  # "statement_batch_deletion" = list(
  #   "name" = "Statement Batch Deletion HTTP Interface",
  #   "description" = "Statements may be deleted individually, using the record’s _id, or in bulk via a batch delete method.",
  #   "route" = "v2/batchdelete/"
  # )
)