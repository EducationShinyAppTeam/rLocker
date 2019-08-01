#'verb
#'
#' xAPI Verb object definitions
#' 
#' @name verb
#' @section Description:
#'   The Verb defines the action between an Actor and an Activity.
#' @section Details:
#'   Verbs appear in Statements as Objects consisting of an IRI and a set of display names corresponding to multiple languages or dialects which provide human-readable meanings of the Verb. The table below lists all properties of the Verb Object.
#' @seealso \link{https://github.com/adlnet/xAPI-Spec/blob/master/xAPI-Data.md#verbs}
NULL

#' Creates an xAPI Verb object
#' 
#' @param verb Verb params
#' @param warn Show warnings
#' 
#' @seealso \code{verb}
#' 
#' @return xAPI Verb object
#' 
#' @examples
#' createVerb(verb = list(display = "custom-verb", id = "https://example.com/xapi/verbs/custom-verb"))
#' 
#' @export
createVerb <- function(
  verb = NULL,
  warn = FALSE, ...) {

  if(is.null(verb) & warn){
    warning("Verb arguments not specified; using default xapi:verb.", call. = FALSE)
  }

  # Set defaults
  # todo: add lookup from verbs list
  # todo: add language support
  # todo: warn - id should be a valid url
  obj <- list(
    id = ifelse(is.null(verb$id), paste(c("http://adlnet.gov/expapi/verbs/", verb$display), collapse = ""), verb$id),
    display = list(
      "en-US" = ifelse(is.null(verb$display), "experienced", verb$display)
    )
  )
  
  class(obj) <- "Verb"

  return(obj)
}

#'@export
getVerb <- function(name, asJSON = FALSE) {
  exists <- exists(name, verbs)

  if (exists & asJSON) {
    return(formatJSON(verbs[name]))
  } else if(exists) {
    return(verbs[name])
  } else {
    return(-1)
  }
}

#'@export
getVerbList <- function() {
  return(names(verbs))
}

verbs <- list(
  "abandoned" = list(
    "id" = "https://w3id.org/xapi/adl/verbs/abandoned",
    "display" = list(
      "en-US" = "abandoned",
      "fr-FR" = "a abandonn\u00e9"
    )
  ),
  "answered" = list(
    "id" = "http://adlnet.gov/expapi/verbs/answered",
    "display" = list(
      "de-DE" = "beantwortete",
      "en-US" = "answered",
      "fr-FR" = "a r\u00e9pondu",
      "es-ES" = "contest\u00f3"
    )
  ),
  "asked" = list(
    "id" = "http://adlnet.gov/expapi/verbs/asked",
    "display" = list(
      "de-DE" = "fragte",
      "en-US" = "asked",
      "fr-FR" = "a demand\u00e9",
      "es-ES" = "pregunt\u00f3"
    )
  ),
  "attempted" = list(
    "id" = "http://adlnet.gov/expapi/verbs/attempted",
    "display" = list(
      "de-DE" = "versuchte",
      "en-US" = "attempted",
      "fr-FR" = "a essay\u00e9",
      "es-ES" = "intent\u00f3"
    )
  ),
  "attended" = list(
    "id" = "http://adlnet.gov/expapi/verbs/attended",
    "display" = list(
      "de-DE" = "nahm teil an",
      "en-US" = "attended",
      "fr-FR" = "a suivi",
      "es-ES" = "asisti\u00f3"
    )
  ),
  "commented" = list(
    "id" = "http://adlnet.gov/expapi/verbs/commented",
    "display" = list(
      "de-DE" = "kommentierte",
      "en-US" = "commented",
      "fr-FR" = "a comment\u00e9",
      "es-ES" = "coment\u00f3"
    )
  ),
  "completed" = list(
    "id" = "http://adlnet.gov/expapi/verbs/completed",
    "display" = list(
      "de-DE" = "beendete",
      "en-US" = "completed",
      "fr-FR" = "a termin\u00e9",
      "es-ES" = "complet\u00f3"
    )
  ),
  "exited" = list(
    "id" = "http://adlnet.gov/expapi/verbs/exited",
    "display" = list(
      "de-DE" = "verlie\u00df",
      "en-US" = "exited",
      "fr-FR" = "a quitt\u00e9",
      "es-ES" = "sali\u00f3"
    )
  ),
  "experienced" = list(
    "id" = "http://adlnet.gov/expapi/verbs/experienced",
    "display" = list(
      "de-DE" = "erlebte",
      "en-US" = "experienced",
      "fr-FR" = "a \u00e9prouv\u00e9",
      "es-ES" = "experiment\u00f3"
    )
  ),
  "failed" = list(
    "id" = "http://adlnet.gov/expapi/verbs/failed",
    "display" = list(
      "de-DE" = "verfehlte",
      "en-US" = "failed",
      "fr-FR" = "a \u00e9chou\u00e9",
      "es-ES" = "fracas\u00f3"
    )
  ),
  "imported" = list(
    "id" = "http://adlnet.gov/expapi/verbs/imported",
    "display" = list(
      "de-DE" = "importierte",
      "en-US" = "imported",
      "fr-FR" = "a import\u00e9",
      "es-ES" = "import\u00f3"
    )
  ),
  "initialized" = list(
    "id" = "http://adlnet.gov/expapi/verbs/initialized",
    "display" = list(
      "de-DE" = "initialisierte",
      "en-US" = "initialized",
      "fr-FR" = "a initialis\u00e9",
      "es-ES" = "inicializ\u00f3"
    )
  ),
  "interacted" = list(
    "id" = "http://adlnet.gov/expapi/verbs/interacted",
    "display" = list(
      "de-DE" = "interagierte",
      "en-US" = "interacted",
      "fr-FR" = "a interagi",
      "es-ES" = "interactu\u00f3"
    )
  ),
  "launched" = list(
    "id" = "http://adlnet.gov/expapi/verbs/launched",
    "display" = list(
      "de-DE" = "startete",
      "en-US" = "launched",
      "fr-FR" = "a lanc\u00e9",
      "es-ES" = "lanz\u00f3"
    )
  ),
  "mastered" = list(
    "id" = "http://adlnet.gov/expapi/verbs/mastered",
    "display" = list(
      "de-DE" = "meisterte",
      "en-US" = "mastered",
      "fr-FR" = "a maîtris\u00e9",
      "es-ES" = "domin\u00f3"
    )
  ),
  "passed" = list(
    "id" = "http://adlnet.gov/expapi/verbs/passed",
    "display" = list(
      "de-DE" = "bestand",
      "en-US" = "passed",
      "fr-FR" = "a r\u00e9ussi",
      "es-ES" = "aprob\u00f3"
    )
  ),
  "preferred" = list(
    "id" = "http://adlnet.gov/expapi/verbs/preferred",
    "display" = list(
      "de-DE" = "bevorzugte",
      "en-US" = "preferred",
      "fr-FR" = "a pr\u00e9f\u00e9r\u00e9",
      "es-ES" = "prefiri\u00f3"
    )
  ),
  "progressed" = list(
    "id" = "http://adlnet.gov/expapi/verbs/progressed",
    "display" = list(
      "de-DE" = "machte Fortschritt mit",
      "en-US" = "progressed",
      "fr-FR" = "a progress\u00e9",
      "es-ES" = "progres\u00f3"
    )
  ),
  "registered" = list(
    "id" = "http://adlnet.gov/expapi/verbs/registered",
    "display" = list(
      "de-DE" = "registrierte",
      "en-US" = "registered",
      "fr-FR" = "a enregistr\u00e9",
      "es-ES" = "registr\u00f3"
    )
  ),
  "responded" = list(
    "id" = "http://adlnet.gov/expapi/verbs/responded",
    "display" = list(
      "de-DE" = "reagierte",
      "en-US" = "responded",
      "fr-FR" = "a r\u00e9pondu",
      "es-ES" = "respondi\u00f3"
    )
  ),
  "resumed" = list(
    "id" = "http://adlnet.gov/expapi/verbs/resumed",
    "display" = list(
      "de-DE" = "setzte fort",
      "en-US" = "resumed",
      "fr-FR" = "a repris",
      "es-ES" = "continu\u00f3"
    )
  ),
  "satisfied" = list(
    "id" = "https://w3id.org/xapi/adl/verbs/satisfied",
    "display" = list(
      "en-US" = "satisfied"
    )
  ),
  "scored" = list(
    "id" = "http://adlnet.gov/expapi/verbs/scored",
    "display" = list(
      "de-DE" = "erreichte",
      "en-US" = "scored",
      "fr-FR" = "a marqu\u00e9",
      "es-ES" = "anot\u00f3"
    )
  ),
  "shared" = list(
    "id" = "http://adlnet.gov/expapi/verbs/shared",
    "display" = list(
      "de-DE" = "teilte",
      "en-US" = "shared",
      "fr-FR" = "a partag\u00e9",
      "es-ES" = "comparti\u00f3"
    )
  ),
  "suspended" = list(
    "id" = "http://adlnet.gov/expapi/verbs/suspended",
    "display" = list(
      "de-DE" = "pausierte",
      "en-US" = "suspended",
      "fr-FR" = "a suspendu",
      "es-ES" = "aplaz\u00f3"
    )
  ),
  "terminated" = list(
    "id" = "http://adlnet.gov/expapi/verbs/terminated",
    "display" = list(
      "de-DE" = "beendete",
      "en-US" = "terminated",
      "fr-FR" = "a termin\u00e9",
      "es-ES" = "termin\u00f3"
    )
  ),
  "voided" = list(
    "id" = "http://adlnet.gov/expapi/verbs/voided",
    "display" = list(
      "de-DE" = "entwertete",
      "en-US" = "voided",
      "fr-FR" = "a annul\u00e9",
      "es-ES" = "anul\u00f3"
    )
  ),
  "waived" = list(
    "id" = "https://w3id.org/xapi/adl/verbs/waived",
    "display" = list(
      "en-US" = "waived"
    )
  )
)
