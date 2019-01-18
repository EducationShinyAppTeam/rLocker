
<!-- README.md is generated from README.Rmd. Please edit that file -->
rlocker
=======

Used to add Learning Locker xAPI support to Shiny Applications.

Installation
------------

You can install the released version of rlocker from [GitHub](https://github.com/) with:

``` r
devtools::install_github("rpc5102/rlocker")
```

Example
-------

**app.R**

``` r
library(shiny)
library(rlocker)

shinyApp(
  server = function(input, output, session) {

    # Initialize Learning Locker connection -- substitute with your own locker credentials
    rlocker::connect(session, list(
      endpoint = "http://localhost:8000/xapi/", 
      auth = "Basic YWNjb3VudEBlbWFpbC5jb206c3VwZXJzZWNyZXRwYXNzd29yZA"
    ))

    # Register events for inputs
    
    # Method 1 - sendCustomMessage (uses js)
    observeEvent(input$submit, {
      session$sendCustomMessage(type = 'create-statement', rlocker::createStatement())
    })
    
    # Method 2 - createStatement and store
    observeEvent(input$button, {
      statement <- rlocker::createStatement()
      rlocker::store(statment)
    })
  }
)
```
