#' model
#' 
#' xAPI interface models
#' @seealso \link{https://docs.learninglocker.net/http-rest/}

#'@export
getModelList <- function() {
  return(names(models))
}

models <- list(
  "lrs" = list(
    "name" = "Learning Record Store",
    "description" = "Learning Locker"
  ),
  "client" = list(
    "name" = "Client",
    "description" = "Credentials that access HTTP Interfaces."
  ),
  "dashboard" = list(
    "name" = "Dashboard",
    "description" = "Customisable grid of visualisations."
  ),
  "download" = list(
    "name" = "Download",
    "description" = "Record of downloaded exports."
  ),
  "export" = list(
    "name" = "Export",
    "description" = "Template for exporting statements."
  )
)