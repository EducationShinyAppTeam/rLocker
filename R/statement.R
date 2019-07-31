#' statement
#' 
#' xAPI Statement object creation functions
#' @importFrom uuid UUIDgenerate
#' @name statement
NULL

#' Creates an xAPI Statement
#' 
#' @param stmt Statement values
#' @param warn Show warnings
#' 
#' @seealso \code{\link{createAgent}}
#' @seealso \code{\link{createVerb}}
#' @seealso \code{\link{createObject}}
#' @seealso \code{\link{createResult}}
#' 
#' @return xAPI Statement (json)
#' 
#' @export
createStatement <- function(stmt = NULL, warn = FALSE, ...) {

  if (is.null(stmt)) {
    warning("No arguments specified; using default xapi:statement.", call. = FALSE)
    warn <- FALSE
  }

  statement <- list(
    actor = do.call(createActor, list(agent = stmt$agent, group = stmt$group, warn = warn)),
    verb = do.call(createVerb, list(verb = stmt$verb, warn = warn)),
    object = do.call(createObject, list(object = stmt$object, warn = warn))
  )

  if (!is.null(stmt$result)) {
    statement$result <- do.call(createResult, list(result = stmt$result, warn = warn))
  }

  return(formatJSON(statement, pretty = TRUE, auto_unbox = TRUE))
}