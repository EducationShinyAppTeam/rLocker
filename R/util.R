#' Utility Functions
#'
#' Load rlocker javascript dependencies
#' @import shiny htmltools
#' @importFrom jsonlite toJSON

# Create link to javascript files for package
.onAttach <- function(...) {
  shiny::addResourcePath("xapiwrapper", system.file("www/js/dist/", package = "rlocker"))
  shiny::addResourcePath("rlocker", system.file("www/js/dist/", package = "rlocker"))
}

# htmlDependency js and css will be used in other functions with attachDependency
xAPIWrapper <- htmltools::htmlDependency(
  name = "xapiwrapper",
  version = "1.10.1",
  src = c("href" = "xapiwrapper"),
  script = "xapiwrapper.min.js"
)

# htmlDependency js and css will be used in other functions with attachDependency
rlockerJS <- htmltools::htmlDependency(
  name = "rlocker",
  version = packageVersion("rlocker"),
  src = c("href" = "rlocker"),
  script = "rlocker.js"
)

dep <- list(xAPIWrapper, rlockerJS)

# ---- Utility Functions ---- #

formatJSON <- function(json, ...) {
  return(jsonlite::toJSON(json, pretty = TRUE, auto_unbox = TRUE, force = TRUE))
}

mailto <- function(email) {
  return(paste0("mailto:", email))
}

#' Returns System RFC 5646 Language Tag
#' @return Always returns en-US
get_system_language_tag <- function() {
  # Returns too many possible language strings to use reliably right now
  # @todo Ideally we'd want language tag + region
  # @seealso \link{https://github.com/adlnet/xAPI-Spec/blob/master/xAPI-Data.md#lang-maps}
  # Sys.getlocale(category = "LC_CTYPE") ==> "en_US.UTF-8" macOS
  return("en-US")
}