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
  
  if(is.null(result) & warn){
    warning('Result arguments not specified; using default xapi:result', call. = FALSE)
  }
  
  # Set defaults
  score = ifelse(is.null(result$score), NA, result$score)
  success = ifelse(is.null(result$success), NA, result$success)
  completion = ifelse(is.null(result$completion), NA, result$completion)
  response = ifelse(is.null(result$response), "DEFAULT_RESPONSE", result$response)
  duration = ifelse(is.null(result$duration), NA, result$duration)
  extensions = ifelse(is.null(result$extensions), NA, result$extensions)
  
  obj <- list(
    success = success,
    completion = completion,
    response = response,
    duration = duration
  )
  
  if(!is.na(score)){
    obj$score = do.call(createScore, list(score = result$score, warn = warn))
  }
  
  # todo: allow multiple extensions
  if(!is.na(extensions)){
    obj$extensions = do.call(createExtension, list(extension = result$extensions, warn = warn))
  }
  
  return(obj)
}

#'@export
getResultDefinition <- function() {
  definition = list(
    score = list(
      scale = NA_integer_,
      raw = NA_integer_,
      min = NA_integer_,
      max = NA_integer_
    ),
    success = c(TRUE, FALSE),
    completion = c(TRUE, FALSE),
    response = NA_character_,
    extensions = NA
  )
  return(definition)
}