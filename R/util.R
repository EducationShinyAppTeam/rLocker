#'Utility Functions
#'
#'Load rlocker javascript dependencies
#'@import shiny htmltools

.onAttach <- function(...) {
  # @todo register the js input handler to make the element reactive
  # shiny::registerInputHandler()

  # Create link to javascript files for package
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
