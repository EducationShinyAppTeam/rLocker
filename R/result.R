#'result
#'
#' xAPI Result object definitions
#' 
#' @name result
#' @section Description:
#'  An optional property that represents a measured outcome related to the Statement in which it is included.
#' @seealso \link{https://github.com/adlnet/xAPI-Spec/blob/master/xAPI-Data.md#result}
NULL

#' Creates an xAPI Result object
#' 
#' @section Extras:
#' This function accepts an optional result value \code{extension}.
#' 
#' @param result Result params
#' @param warn Show warnings
#' 
#' @seealso \code{\link{result}}
#' @seealso \code{\link{createExtension}}
#' 
#' @return xAPI Result object
#' 
#' @examples
#' createResult(result = list(success = TRUE, response = "correctAnswer"))
#' createResult(result = list(success = TRUE, response = "correctAnswer", extension = list(ref = "https://w3id.org/xapi/cmi5/result/extensions/progress", value = 100)))
#' 
#' @export
createResult <- function(
  result = NULL,
  warn = FALSE, ...) {

  if (is.null(result) & warn) {
    warning("Result arguments not specified; using default xapi:result", call. = FALSE)
  }
  
  obj <- list()
  
  # ---- Optional Values ---- #
  if (!is.null(result$success)) {
    # todo: check if boolean value or can be coerced 
    obj$success <- result$success
  }
  
  if (!is.null(result$completion)) {
    # todo: check if boolean value or can be coerced 
    obj$completion <- result$completion
  }
  
  if (!is.null(result$response)) {
    obj$response <- result$response
  }
  
  if (!is.null(result$score)) {
    obj$score <- do.call(createScore, list(score = result$score, warn = warn))
  }
  
  if (!is.null(result$duration)) {
    obj$duration <- result$duration
  }

  # todo: allow multiple extensions
  if (!is.null(result$extensions)) {
    obj$extensions <- do.call(createExtension, list(extension = result$extensions, warn = warn))
  }
  
  class(obj) <- "Result"

  return(obj)
}

#'@export
getResultDefinition <- function() {
  definition <- list(
    score = getScoreDefinition(),
    success = c(TRUE, FALSE),
    completion = c(TRUE, FALSE),
    response = NA_character_,
    extensions = getExtensionDefinition()
  )
  
  return(definition)
}