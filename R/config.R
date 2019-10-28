#'config
#'
#' @name config
NULL

set_locker_config <- function(config){
  httr::set_config(
    add_headers(
      Authorization = config$auth
    )
  )
  
  invisible(options(locker_config = config))
}

get_locker_config <- function(){
  return(getOption("locker_config"))
}