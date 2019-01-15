
<!-- README.md is generated from README.Rmd. Please edit that file -->
rlocker
=======

Used to add Learning Locker xAPI support for Shiny Applications. **Warning**: this package is still in development.

Installation
------------

You can install the released version of rlocker from [GitHub](https://github.com) with:

``` r
devtools::install_github("rpc5102/rlocker")
```

Example
-------

**server.R**

``` r
library(httr)
library(shiny)
library(rlocker)

# sample lrs endpoint and credentials
config <- list(
  endpoint = "http://localhost:8000/xapi/", 
  auth = "Basic YWNjb3VudEBlbWFpbC5jb206c3VwZXJzZWNyZXRwYXNzd29yZA"
)

# set up an observer to pass credentials to our locker
server <- function(input, output, session) {
  rlocker::create(session, config)
}
```
