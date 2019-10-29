library(shiny)
library(rlocker)

# Import question set as global var to save on resources.
source("./questions.R")

shinyApp(
  ui = fluidPage(

    # Application title
    titlePanel("rlocker demo"),
    hr(),

    # Begin Quiz Questions
    fluidRow(
      uiOutput("questionset")
    ),
    actionButton("submit", "Submit"),
    hr(),

    # Statements generated
    tags$samp(
      htmlOutput("statements")
    )
  ),
  server = function(input, output, session) {

    # Setup locker configuration
    config <- list(
      base_url = "https://learning-locker.stat.vmhost.psu.edu/",
      auth = "Basic ZDQ2OTNhZWZhN2Q0ODRhYTU4OTFmOTlhNWE1YzBkMjQxMjFmMGZiZjo4N2IwYzc3Mjc1MzU3MWZkMzc1ZDliY2YzOTNjMGZiNzcxOThiYWU2",
      agent = rlocker::createAgent()
    )

    # Initialize Learning Locker connection
    connection <- rlocker::connect(session, config)

    # Import helper functions to setup demo app and user.
    source("./helpers.R", local = TRUE)

    # Set up question input list
    output$questionset <- renderUI({
      renderQuestionset(questions)
    })

    # Set up graphics for question items
    output$rnorm <- renderPlot({
      hist(main = "", xlab = "", ylab = "", rnorm(n = 1000, mean = 24.2, sd = 2.2))
    })

    output$rlnorm <- renderPlot({
      hist(main = "", xlab = "", ylab = "", rlnorm(1000))
    })

    # Register events for question inputs
    registerQuestionEvents(session, questions)
  }
)
