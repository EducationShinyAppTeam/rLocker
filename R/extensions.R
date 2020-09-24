#'extensions
#'
#' xAPI Extension object definitions
#'
#' @name extensions
#' @section Description:
#'   Extensions are available as part of Activity Definitions, as part of a Statement's "context" property, or as part of a Statement's "result" property. In each case, extensions are intended to provide a natural way to extend those properties for some specialized use. The contents of these extensions might be something valuable to just one application, or it might be a convention used by an entire Community of Practice.
#' @section Details:
#'   Extensions are defined by a map and logically relate to the part of the Statement where they are present. The values of an extension can be any JSON value or data structure. Extensions in the "context" property provide context to the core experience, while those in the "result" property provide elements related to some outcome. Within Activities, extensions provide additional information that helps define an Activity within some custom application or Community of Practice. The meaning and structure of extension values under an IRI key are defined by the person who controls the IRI
#' @seealso \link{https://github.com/adlnet/xAPI-Spec/blob/master/xAPI-Data.md#miscext}
NULL

#' Creates an xAPI Extension object
#'
#' @param ref Internationalized resource identifier (uri extension)
#' @param value Any value matching corresponding reference definition constraints
#'
#' @seealso \code{extension}
#'
#' @return Extension
#'
#' @examples
#' createExtension(
#'   extension = list(
#'     ref = "https://w3id.org/xapi/cmi5/result/extensions/progress",
#'     value = 100
#'   )
#' )
#'
#' @export
createExtension <- function(
  extension = NULL,
  warn = FALSE, ...) {

  if (is.null(extension) & warn) {
    warning("Extension arguments not specified; using default xapi:extension", call. = FALSE)
  }

  # Set defaults
  dfn <- getExtensionDefinition()

  ref <- ifelse(is.null(extension$ref), dfn$ref, extension$ref)
  value <- ifelse(is.null(extension$value), dfn$value, extension$value)

  obj <- list()
  obj[ref] <- value

  class(obj) <- "Extension"

  return(obj)
}

#' getExtensionDefinition
#' 
#' Returns an empty Extension object with possible arguments.
#' 
#' @return definition
#' 
#'@export
getExtensionDefinition <- function() {
  definition <- list(
    ref = NA_character_,
    value = NA_character_
  )
  return(definition)
}