#' statement
#' 
#' xAPI Statement object creation functions
#' @importFrom uuid UUIDgenerate
#' @name statement
NULL

#' Creates an xAPI Statement
#' 
#' @param x Statement values
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
createStatement <- function(x = NULL, warn = FALSE, ...) {
  params <- x
  
  if(is.null(params)){
    warning('No arguments specified; using default xapi:statement.', call. = FALSE)
    warn = FALSE
  }
  
  # todo: check if verb requires a result object

  statement <- list(
    agent = do.call(createAgent, list(agent = params$agent, warn = warn)),
    verb = do.call(createVerb, list(verb = params$verb, warn = warn)),
    object = do.call(createObject, list(object = params$object, warn = warn)),
    result = do.call(createResult, list(result = params$result, warn = warn))
  )

  return(formatJSON(statement, pretty = TRUE, auto_unbox = TRUE))
}