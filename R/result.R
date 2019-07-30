#'result
#'
#' xAPI Result object definitions
#' 
#' @section Description:
#'  An optional property that represents a measured outcome related to the Statement in which it is included.

#' Creates an xAPI Result object
#' 
#' @section Extras:
#' This function accepts an optional result value \code{extension}.
#' 
#' @param success Indicates whether or not the attempt on the Activity was successful.
#' @param response A response appropriately formatted for the given Activity.
#' @param warn Show warnings
#' 
#' @seealso \code{\link{result}}
#' @seealso \code{\link{createExtension}}
#' 
#' @return xAPI Result object
#' 
#' @examples
#' createResult(result = list(success = TRUE, response = "correctAnswer"))
#' 
#' @export
createResult <- function(
  result = NULL,
  warn = FALSE, ...) {
  
  if(is.null(result) & warn){
    warning('Result arguments not specified; using default xapi:result', call. = FALSE)
  }
  
  # Set defaults
  success = ifelse(is.null(result$success), NA, result$success)
  response = ifelse(is.null(result$response), "DEFAULT_RESPONSE", result$response)
  extensions = ifelse(is.null(result$extensions), NA, result$extensions)
  
  obj <- list(
    success = success,
    response = response
  )
  
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