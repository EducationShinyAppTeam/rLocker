#'result
#'
#' xAPI Result object definitions
#' 
#' @section Description:
#'  An optional property that represents a measured outcome related to the Statement in which it is included.

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
    response = NA_character_
  )
  return(definition)
}