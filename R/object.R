#'object
#'
#' xAPI Object object definitions
#'
#' @section Description:
#'   The Object defines the thing that was acted on. The Object of a Statement can be an Activity, Agent/Group, SubStatement, or Statement Reference.
#' @section Details:
#'   Objects which are provided as a value for this property SHOULD include an "objectType" property. If not specified, the objectType is assumed to be Activity. Other valid values are: Agent, Group, SubStatement or StatementRef. The properties of an Object change according to the objectType.
#' @seealso \link{https://github.com/adlnet/xAPI-Spec/blob/master/xAPI-Data.md#object}
#'

#'@export
getObjectTypes <- function() {
  return(objectTypes)
}

#'@export
getInteractionTypes <- function() {
  return(names(interactionTypes))
}

#'@export
getInteractionType <- function(name, asJSON = FALSE) {
  exists = exists(name, interactionTypes)
  
  if(exists & asJSON) {
    return(formatJSON(interactionTypes[name]))
  } else if(exists) {
    return(interactionTypes[name])
  } else {
    return(-1)
  }
}

objectTypes <- c(
  "Activity",
  "Agent",
  "Group",
  "Statement Reference",
  "SubStatement"
)

components <- list(
  "choices" = list(
    "definition" = "An Array of interaction components",
    "sample" = "[
    {
    'id': 'likert_0',
    'description': {
    'en-US': 'It\'s OK'
    }
    },
    {
    'id': 'likert_1',
    'description': {
    'en-US': 'It\'s Pretty Cool'
    }
    },
    {
    'id': 'likert_2',
    'description': {
    'en-US': 'It\'s Very Cool'
    }
    },
    {
    'id': 'likert_3',
    'description': {
    'en-US': 'It\'s Gonna Change the World'
    }
    }
    ]"
  ),
  "sequencing" = list(
    "definition" = "An Array of interaction components",
    "sample" = ""
  ),
  "source"= list(
    "definition" = "An Array of interaction components",
    "sample" = ""
  ),
  "target"= list(
    "definition" = "An Array of interaction components",
    "sample" = ""
  ),
  "steps"= list(
    "definition" = "An Array of interaction components",
    "sample" = ""
  )
  )

interactionTypes <- list(
  "choice" = list(
    "components" = components$choices,
    "description" = "A list of the options available in the interaction for selection or ordering."
  ),
  "sequencing" = list(
    "components" = components$choices,
    "description" = "A list of the options available in the interaction for selection or ordering."
  ),
  "likert" = list(
    "components" = components$scale,
    "description" = "A list of the options on the likert scale."
  ),
  "matching" = list(
    "components" = c(components$source, components$target),
    "description" = "Lists of sources and targets to be matched."
  ),
  "performance" = list(
    "components" = components$steps,
    "description" = "A list of the elements making up the performance interaction."
  ),
  "true-false" = list(
    "components" = NA,
    "description" = "A Logical value."
  ),
  "fill-in" = list(
    "components" = NA,
    "description" = "A Character value."
  ),
  "long-fill-in" = list(
    "components" = NA,
    "description" = "A long Character value."
  ),
  "numeric" = list(
    "components" = NA,
    "description" = "Numeric or Integer values."
  ),
  "other" = list(
    "components" = NA,
    "description" = NA_character_
  )
)

