#' model
#' 
#' xAPI interface models
#' @seealso \link{https://docs.learninglocker.net/http-rest/}

#'@export
getModelList <- function() {
  return(names(models))
}

#'@export
getModel <- function(name, asJSON = FALSE) {
  exists <- exists(name, models)
  
  if (exists & asJSON) {
    return(formatJSON(models[[name]]))
  } else if(exists) {
    return(
      structure(
        models[[name]],
        class = "model"
      )
    )
  } else {
    return(-1)
  }
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
  ),
  "journey" = list(
    "name" = "Journey",
    "description" = " [Enterprise] Journeys visualisation."
  ),
  "journeyprogress" = list(
    "name" = "Journey Progress",
    "description" = " [Enterprise] Journeys progress."
  ),
  "organisation" = list(
    "name" = "Organisation",
    "description" = "Container of clients and stores that a subset of users can access."
  ),
  "persona" = list(
    "name" = "Persona",
    "description" = "Person with many identifiers and attributes across systems."
  ),
  "personaidentifier" = list(
    "name" = "Persona Identifier",
    "description" = "Unique xAPI identifier for a persona."
  ),
  "personaattribute" = list(
    "name" = "Persona Attribute",
    "description" = "Attribute of a persona."
  ),
  "query" = list(
    "name" = "Query",
    "description" = "Saved filter for statements."
  ),
  "role" = list(
    "name" = "Role",
    "description" = "Group of permissions for accessing organisation data via users."
  ),
  "store" = list(
    "name" = "Store",
    "description" = "Container for xAPI data (statements, documents, and attachments)."
  ),
  "user" = list(
    "name" = "User",
    "description" = "Login details for accessing the UI."
  ),
  "visualisation" = list(
    "name" = "Visualisation",
    "description" = "Graphical view of statements."
  )
)