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

#' Creates an xAPI Object object
#' 
#' @param name Object name
#' @param description Brief description of the object
#' @param id URI to object or activity
#' @param warn Show warnings
#' 
#' @seealso \code{object}
#' 
#' @return xAPI Object object
#' 
#' @examples
#' createObject(object = list(name = "Question 1", description = "Example question description."))
#' 
#' @export
createObject <- function(
  object = NULL,
  warn = FALSE, ...) {
  
  if(is.null(object) & warn){
    warning('Object arguments not specified; using default xapi:object.', call. = FALSE)
  }
  
  # Set defaults
  id <- ifelse(is.null(object$id), "http://adlnet.gov/expapi/activities/example", object$id)
  name <- ifelse(is.null(object$name), "Example Activity", object$name)
  description <- ifelse(is.null(object$description), "Example activity description", object$description)
  type <- ifelse(is.null(object$type), "Activity", object$id)
  moreInfo <- ifelse(is.null(object$moreInfo), NA, object$moreInfo)
  interactionType <- ifelse(is.null(object$interactionType), NA, object$interactionType)
  extensions <- ifelse(is.null(object$extensions), NA, object$extensions)
  
  # todo: split option path by object type (not all values will be supported by each type)
  
  # Set required values
  obj <- list(
    id = id,
    definition = list(
      name = list(
        "en-US" = name
      ),
      description = list(
        "en-US" = description
      )
    )
  )
  
  # ---- Optional Values ----
  
  # More info link
  if(!is.na(moreInfo) && type == "Activity"){
    obj$moreInfo = moreInfo
  }
  
  # Interaction type
  if(!is.na(interactionType) && type == "Activity"){
    obj$definition$interactionType = interactionType
    
    # Check for warnings
    validateObject(obj$definition)
  }
  
  # Extensions
  # todo: allow multiple extensions
  if(!is.na(extensions) && type == "Activity"){
    obj$definition$extensions = do.call(createExtension, list(extension = object$extensions, warn = warn))
  }
  
  obj$objectType <- type
  
  return(obj)
}

#'@export
getObjectDefinition <- function() {
  definition <- list(
    name = NA_character_,
    description = NA_character_,
    type = NA_character_,
    moreInfo = NA_character_,
    interactionType = NA_character_,
    choices = NA_character_,
    sequencing = NA_character_,
    likert = NA_character_,
    source = NA_character_,
    target = NA_character_,
    steps = NA_character_,
    extensions = NA
  )
  return(definition)
}

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

#'@export
getInteractionComponent <- function(name, asJSON = FALSE){
  exists = exists(name, components)
  
  if(exists & asJSON) {
    return(formatJSON(components[name]))
  } else if(exists) {
    return(components[name])
  } else {
    return(-1)
  }
}

#'@export
getInteractionComponents <- function(){
  return(names(components))
}

#'@export
getSupportedComponents <- function(interactionType) {
  exists <- match(interactionType, getInteractionTypes())

  if(is.na(exists)){
    return(NA)
  } else {
    return(getInteractionType(interactionType)[[1]]$components)
  }
}

#'@export
checkSupportedComponents <- function(object) {
  supported <- getSupportedComponents(object$interactionType)
  available <- getInteractionComponents()
  exists <- match(object$interactionType, getInteractionTypes())
  
  flag <- FALSE
  
  if(!is.na(exists)){
    for(i in names(object)){
      if(!is.na(match(i, available) >= 1)){
        if(is.na(match(i, supported))){
          warning(paste0('Interaction component "', i, '" not supported by interaction type "', object$interactionType, '" provided; this value will be dropped.'), call. = FALSE)
          flag <- TRUE
        }
      }
    }
  } else {
    warning(paste0('Interaction type "', object$interactionType, '" is not a valid type.'), call. = FALSE)
    flag <- TRUE
  }
  
  return(!flag)
}

#'@export
validateObject <- function(object) {
  dfn <- names(getObjectDefinition())
  validKeys <- all(names(object) %in% dfn)
  for(key in names(object)){
    if(!(key %in% dfn)){
      warning(paste0('Object property "', key, '" is not valid.'), call. = FALSE)
    }
  }
  validComponents <- checkSupportedComponents(object)
  passed <- validKeys & validComponents
  
  return(passed)
}

objectTypes <- c(
  "Activity",
  "Agent",
  "Group",
  "Statement Reference",
  "SubStatement"
)

# todo: format as r object instead of json
components <- list(
  "choices" = list(
    "definition" = "An Array of interaction components to be chosen.",
    "sample" = '[
      {
        "id": "choice_a",
        "description": {
          "en-US": "Cyan"
        }
      },
      {
        "id": "choice_b",
        "description": {
          "en-US": "Magenta"
        }
      },
      {
        "id": "choice_c",
        "description": {
          "en-US": "Yellow"
        }
      },
      {
        "id": "choice_d",
        "description": {
          "en-US": "Black"
        }
      }
    ]'
  ),
  "sequencing" = list(
    "definition" = "An Array of interaction components to be ordered.",
    "sample" = '[
      {
        "id": "choice_1",
        "description": {
          "en-US": "1"
        }
      },
      {
        "id": "choice_2",
        "description": {
          "en-US": "2"
        }
      },
      {
        "id": "choice_3",
        "description": {
          "en-US": "3"
        }
      },
      {
        "id": "choice_4",
        "description": {
          "en-US": "4"
        }
      }
    ]'
  ),
  "likert"= list(
    "definition" = "A list of the options on the likert scale.",
    "sample" = '[
      {
        "id": "likert_1",
        "description": {
          "en-US": "Strongly disagree"
        }
      },
      {
        "id": "likert_2",
        "description": {
          "en-US": "Disagree"
        }
      },
      {
        "id": "likert_3",
        "description": {
          "en-US": "Neutral"
        }
      },
      {
        "id": "likert_4",
        "description": {
          "en-US": "Agree"
        }
      },
      {
        "id": "likert_5",
        "description": {
          "en-US": "Strongly agree"
        }
      }
    ]'
  ),
  "source"= list(
    "definition" = "An Array of origin interaction components (for matching).",
    "sample" = '[
      {
        "id": "source_1",
        "description": {
          "en-US": "Apple"
        }
      },
      {
        "id": "source_2",
        "description": {
          "en-US": "Broccoli"
        }
      },
      {
        "id": "source_3",
        "description": {
          "en-US": "Carrot"
        }
      },
      {
        "id": "source_4",
        "description": {
          "en-US": "Durian"
        }
      }
    ]'
  ),
  "target"= list(
    "definition" = "An Array of destination interaction components (for matching).",
    "sample" = '[
      {
        "id": "target_1",
        "description": {
          "en-US": "Fruit"
        }
      },
      {
        "id": "target_2",
        "description": {
          "en-US": "Vegetable"
        }
      }
    ]'
  ),
  "steps"= list(
    "definition" = "An Array of interaction components by logical steps.",
    "sample" = '[
      {
        "id": "step_1",
        "description": {
          "en-US": "Novice"
        }
      },
      {
        "id": "step_2",
        "description": {
          "en-US": "Advanced Beginner"
        }
      },
      {
        "id": "step_3",
        "description": {
          "en-US": "Competent"
        }
      },
      {
        "id": "step_4",
        "description": {
          "en-US": "Proficient"
        }
      },
      {
        "id": "step_5",
        "description": {
          "en-US": "Expert"
        }
      }
    ]'
  )
)

interactionTypes <- list(
  "choice" = list(
    "components" = "choices",
    "description" = "A list of the options available in the interaction for selection."
  ),
  "sequencing" = list(
    "components" = "choices",
    "description" = "A list of the options available in the interaction for ordering."
  ),
  "likert" = list(
    "components" = "scale",
    "description" = "A list of the options on the likert scale."
  ),
  "matching" = list(
    "components" = c("source", "target"),
    "description" = "Lists of sources and targets to be matched."
  ),
  "performance" = list(
    "components" = "steps",
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

