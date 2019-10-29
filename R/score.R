#'score
#'
#' xAPI Score object definitions
#' 
#' @name score
#' @section Description:
#'  An optional property that represents the outcome of a graded Activity achieved by an Agent.
#' @section Requirements:
#' - The Score Object SHOULD include "scaled" if a logical percent based score is known.
#' - The Score Object SHOULD NOT be used for scores relating to progress or completion. Consider using an extension (preferably from an established Community of Practice) instead.
#' @seealso \link{https://github.com/adlnet/xAPI-Spec/blob/master/xAPI-Data.md#2451-score}
NULL

#' Creates an xAPI Score object
#'
#' @param score Score params
#' @param warn Show warnings; ignored for important warnings.
#' 
#' @seealso \code{\link{score}}
#' 
#' @return xAPI Score object
#' 
#' @examples
#' createScore(score = list(scaled = 0, raw = 80, min = 0, max = 100))
#' 
#' @export
createScore <- function(
  score = NULL,
  warn = FALSE, ...) {

  if (is.null(score) & warn) {
    warning('Score arguments not specified; using default xapi:score', call. = FALSE)
  }

  # Set defaults
  scaled  <- ifelse(is.null(score$scaled), 0, score$scaled)
  raw     <- ifelse(is.null(score$raw), NA, score$raw)
  min     <- ifelse(is.null(score$min), NA, score$min)
  max     <- ifelse(is.null(score$max), NA, score$max)

  if (scaled < -1 | scaled > 1) {
    warning("A score's scale must be between -1 and 1 (inclusive); defaulting to 0.", call. = FALSE)
    scaled <- 0
  }

  if (!is.na(raw < min) & raw < min) {
    warning(paste0("A score's raw value must be greater than the min value provided; currently ", raw, " defaulting to ", min, "."), call. = FALSE)
    raw <- min
  }

  if (!is.na(raw > max) & raw > max) {
    warning(paste0("A score's raw value must be less than the max value provided; currently ", raw, " defaulting to ", max, "."), call. = FALSE)
    raw <- max
  }

  obj <- list(
    scaled = scaled,
    raw = raw,
    min = min,
    max = max
  )
  
  class(obj) <- "Score"

  return(obj)
}

#'@export
getScoreDefinition <- function() {
  definition <- list(
    scaled = NA_integer_,
    raw = NA_integer_,
    min = NA_integer_,
    max = NA_integer_
  )
  
  return(definition)
}