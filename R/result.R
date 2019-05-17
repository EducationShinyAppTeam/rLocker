#'result
#'
#' xAPI Result object definitions

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