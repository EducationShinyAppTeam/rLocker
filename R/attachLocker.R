#'attachLocker
#'learningLocker
#'
#'@param endpoint Learning Locker API - Endpoint
#'@param user Learning Locker API - Auth User
#'@param password Learning Locker API - Auth Password
#'@param auth Learning Locker API - Auth Token
#'@import htmltools
#'@import httr

# ### REMOVE ME ### #
# Useful docs:
# https://cran.r-project.org/web/packages/tryCatchLog/vignettes/tryCatchLog-intro.html
# https://cran.r-project.org/web/packages/httr/vignettes/quickstart.html

locker <- structure(c(), class = "locker")

#'@export
test <- function(
  testpoint = "http://localhost:8000/data/xAPI/about",
  auth = NULL,
  user = NULL,
  password = NULL) {

  status = 418 # temp
  args <- as.list(match.call())

  # Check to see if auth token is set or if username and password are set instead.
  if(is.null(auth) | (is.null(auth) & is.null(password))){
    stop("Locker credentials are not set; unable to proceed.")
  }

  # Try making a connection to the endpoint
  tryCatch({

    # @todo check if endpoint has data/xapi

      status <- status_code(GET(paste(c(endpoint, "/about"), collapse="")))

      if(!status == 200){
        print(endpoint)
        stop(paste(c("Unable to connect to endpoint.\n\tReason: ", http_status(status)$message)))
      }
    },
    error = function(e){ stop(e$message)
  })

  return(status)
}

#'@export
create <- function(session, config) {
  insertUI(selector = "head", where = "beforeEnd", ui = htmltools::attachDependencies(htmltools::tags$head(), dep, append = TRUE), immediate = TRUE, session = getDefaultReactiveDomain())
  session$sendCustomMessage("rlocker-setup", config)
}

#'@export
observeEvents <- function(session, config) {
  session$sendCustomMessage("custom-action", config)
}
