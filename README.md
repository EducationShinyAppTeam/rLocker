<!-- README.md is generated from README.Rmd. Please edit that file -->

# rlocker <img src="https://github.com/rpc5102/rlocker/blob/master/rlocker.png?raw=true" align="right" height=140>

<!-- badges: start -->

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/rlocker)](https://cran.r-project.org/package=rlocker)
[![License:
GPLv3](https://img.shields.io/github/license/rpc5102/rlocker.svg?style=flat)](https://opensource.org/licenses/GPL-3.0)
<!-- badges: end -->

Learning Locker xAPI support for Shiny Applications.

### About xAPI

> xAPI \[Experience API\] is 100% free, open source, lightweight, and adaptable. It can be used to augment almost any performance assessment situation. It is being used in an expanding array of learning systems, from LMSs and simulator systems to museums and emergency medical services. – [adlnet.gov](https://adlnet.gov/projects/xapi/)

See also: [What is the Experience API?](https://xapi.com/overview/)

### Assumptions

1.  This package assumes that you have a [Learning
    Locker](https://www.ht2labs.com/learning-locker-community/overview/)
    instance set up and that it’s reachable by your application.
2.  Your application is running in an environment that supports
    [Cross-Origin Resource Sharing
    (CORS)](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS);
    otherwise API requests will be blocked. Requests made from
    `localhost` / `127.0.0.1` / RStudio’s `runApp()` are often blocked
    for this reason.
3.  You are given consent by the application user(s) to collect activity
    data on them. **Note**: unless specified, user identifiers are
    anonymized by default.

### Installation

You can install the released version of rlocker from
[GitHub](https://github.com/) with:

``` r
devtools::install_github("rpc5102/rlocker")
```

### Examples

See the [examples](./inst/examples/) folder for demo code or visit psu-eberly.shinyapps.io/rlocker to see it in action.

### Storage Mechanism

Below are two approaches to creating and storing a simple xAPI statement
in Learning Locker.

#### Method 1: R handler

###### app.R

``` r
library(shiny)
library(rlocker)

shinyApp(
  server = function(input, output, session) {

    # Initialize Learning Locker connection -- substitute with your own locker credentials
    rlocker::connect(session, list(
      base_url = "https://learning-locker.example.com/",
      endpoint = "/data/xAPI/",
      auth = "Basic YWNjb3VudEBlbWFpbC5jb206c3VwZXJzZWNyZXRwYXNzd29yZA"
    ))

    # Register input event for interactive elements
    observeEvent(input$button, {
      statement <- rlocker::createStatement()
      rlocker::store(statement)
    })
  }
)
```

#### Method 2: JavaScript handler

###### app.R

``` r
library(shiny)
library(rlocker)

shinyApp(
  ui = fluidPage(
    # Attach js logic
    tags$script(src = "js/app.js"),
    
    # Application title
    titlePanel("rlocker demo"),
    fluidRow(
      actionButton("button", "Press me!")
    )
  ),
  server = function(input, output, session) {

    # Initialize Learning Locker connection -- substitute with your own locker credentials
    config <- jsonlite::toJSON(
      list(
        base_url = "https://learning-locker.example.com/",
        endpoint = "/data/xAPI/",
        auth = "Basic YWNjb3VudEBlbWFpbC5jb206c3VwZXJzZWNyZXRwYXNzd29yZA"
      ),
      pretty = TRUE,
      auto_unbox = TRUE,
      force = TRUE
    )
    
    session$sendCustomMessage(type = 'rlocker-setup', config)
    
    # Register input events for interactive elements
    observeEvent(input$button, {
      session$sendCustomMessage(type = 'rlocker-store', rlocker::createStatement())
    })
  }
)
```

###### www/js/app.js

``` js
Shiny.addCustomMessageHandler('rlocker-setup', function(config) {
  /* connection logic */
});

Shiny.addCustomMessageHandler('rlocker-store', function(values) {
  /* storage logic */
});
```

See [adlnet/xAPIWrapper](https://github.com/adlnet/xAPIWrapper/) for
JavaScript implementations.

### Data Retreival

Stored statements can be retreived from Learning Locker by using the
`retrieve` method.

**Note**: This requires a connection to be established by the R-handler
to work; JS implementations can interface with the API through
[XMLHttpRequest](https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/Using_XMLHttpRequest)
instead.

###### app.R

``` r
response <- rlocker::retrieve(
  interface = "connection",
  model = "statement",
  query = "first=1",
  asJSON = TRUE
)

print(response)
```

Response data can be returned as a JSON formatted string or as an R
object (default). Below is sample output from the request above.

###### OUTPUT JSON

``` json
{
  "edges": [
    {
      "cursor": "eyJfaWQiOiI1YzQ2MmRiYjI0ZjVmMDRhOTI0MjZlMWMifQ==",
      "node": {
        "person": {},
        "completedQueues": [],
        "processingQueues": [],
        "deadForwardingQueue": [],
        "pendingForwardingQueue": [],
        "completedForwardingQueue": [],
        "_id": "5c462dbb24f5f04a92426e1c",
        "hasGeneratedId": false,
        "organisation": "5c4383e369b9834b4e086caa",
        "lrs_id": "5c46260e85ce554a24b7579f",
        "client": "5c46260e85ce554a24b757a0",
        "active": true,
        "voided": false,
        "timestamp": "2019-01-21T20:38:19.131Z",
        "stored": "2019-01-21T20:38:19.131Z",
        "hash": "0905ec8aa05e67d247d7c888baf80b1f65c439c9",
        "agents": [
          "886b382eb3a9570aeb3da9b34028a76ed761f1b9"
        ],
        "relatedAgents": [
          "886b382eb3a9570aeb3da9b34028a76ed761f1b9",
          "mailto:hello@learninglocker.net"
        ],
        "registrations": [],
        "verbs": [
          "http://adlnet.gov/expapi/verbs/launched"
        ],
        "activities": [
          "http://127.0.0.1:4358/"
        ],
        "relatedActivities": [
          "http://127.0.0.1:4358/"
        ],
        "statement": {
          "actor": {
            "objectType": "Agent",
            "name": "b5958c7b-22ba-404f-af7d-e5c3ccc6ddea",
            "mbox_sha1sum": "886b382eb3a9570aeb3da9b34028a76ed761f1b9"
          },
          "verb": {
            "id": "http://adlnet.gov/expapi/verbs/launched",
            "display": {
              "en-US": "launched"
            }
          },
          "object": {
            "objectType": "Activity",
            "id": "http://127.0.0.1:4358/",
            "definition": {
              "name": {
                "en-US": "rlocker demo"
              }
            }
          },
          "id": "baa14dff-fbb2-4722-94a2-ecb268193436",
          "timestamp": "2019-01-21T20:38:19.131Z",
          "stored": "2019-01-21T20:38:19.131Z",
          "authority": {
            "objectType": "Agent",
            "name": "New Client",
            "mbox": "mailto:hello@learninglocker.net"
          },
          "version": "1.0.0"
        },
        "failedForwardingLog": []
      }
    }
  ],
  "pageInfo": {
    "hasNextPage": true,
    "hasPreviousPage": false,
    "startCursor": "eyJfaWQiOiI1YzQ2MmRiYjI0ZjVmMDRhOTI0MjZlMWMifQ==",
    "endCursor": "eyJfaWQiOiI1YzQ2MmRiYjI0ZjVmMDRhOTI0MjZlMWMifQ=="
  }
}
```

See [HTTP Queries](https://docs.learninglocker.net/http-queries/) for
more information on how to make calls to the records database.

### Configuration

| option    | default                                                  |
| --------- | -------------------------------------------------------- |
| base\_url | <http://localhost:8000/xapi/>                            |
| endpoint  | /data/xAPI/                                              |
| auth      | Basic YWNjb3VudEBlbWFpbC5jb206c3VwZXJzZWNyZXRwYXNzd29yZA |
| username  | null                                                     |
| password  | null                                                     |

**Note**: *base\_url* should be the hosting location for your locker’s
API *without* any endpoint or home.
