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
xAPIWrapper = htmltools::htmlDependency(
  name = "xapiwrapper",
  version = "1.10.1",
  src = c("href" = "xapiwrapper"),
  script = "xapiwrapper.min.js"
)

# htmlDependency js and css will be used in other functions with attachDependency
rlockerJS = htmltools::htmlDependency(
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

mailto <- function(email){
  return(paste0("mailto:", email))
}