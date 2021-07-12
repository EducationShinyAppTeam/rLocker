#' util
#'
#' Utility Functions
#' 
#' @import shiny htmltools
#' @importFrom jsonlite toJSON
NULL

#' .onAttach
#' 
#' Create link to javascript files for package using the shiny::onAttach hook.
.onAttach <- function(...) {
  shiny::addResourcePath("xapiwrapper", system.file("www/js/dist/", package = "rLocker"))
  shiny::addResourcePath("rLocker", system.file("www/js/dist/", package = "rLocker"))
}

#' xAPIWrapper
#' 
#' htmlDependency js and css that will be used in other functions with attachDependency
xAPIWrapper <- htmltools::htmlDependency(
  name = "xapiwrapper",
  version = "1.10.1",
  src = c("href" = "xapiwrapper"),
  script = "xapiwrapper.min.js"
)

#' rLockerJS
#' 
#' htmlDependency js and css will be used in other functions with attachDependency
rLockerJS <- htmltools::htmlDependency(
  name = "rLocker",
  version = packageVersion("rLocker"),
  src = c("href" = "rLocker"),
  script = "rLocker.js"
)

dep <- list(xAPIWrapper, rLockerJS)

# ---- Utility Functions ---- #

#' formatJSON
#' 
#' Uses jsonlite to format json with a set of default params.
#' 
#' @param json JSON
#' @param ... jsonlite args
#' 
#' @return json
formatJSON <- function(json, ...) {
  return(jsonlite::toJSON(json, pretty = TRUE, auto_unbox = TRUE, force = TRUE))
}

#' mailto
#' 
#' Creates a simple mailto address from a given email address.
#' 
#' @param email E-mail address
#' 
#' @return mailto:address
mailto <- function(email) {
  return(paste0("mailto:", email))
}

#' get_system_language_tag
#' 
#' Returns System RFC 5646 Language Tag
#' 
#' @return Always returns en-US
get_system_language_tag <- function() {
  # Returns too many possible language strings to use reliably right now
  # @todo Ideally we'd want language tag + region
  # @seealso \link{https://github.com/adlnet/xAPI-Spec/blob/master/xAPI-Data.md#lang-maps}
  # Sys.getlocale(category = "LC_CTYPE") ==> "en_US.UTF-8" macOS
  return("en-US")
}
