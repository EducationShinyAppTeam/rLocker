library(shiny)
library(rlocker)

# Contains question setup and rendering functions
source('./helpers.R')

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

    # Initialize Learning Locker connection
    rlocker::connect(session, list(
      endpoint = "http://localhost:8000/xapi/",
      auth = "Basic YWNjb3VudEBlbWFpbC5jb206c3VwZXJzZWNyZXRwYXNzd29yZA"
    ))

    # Set up question list
    output$questionset <- renderUI({
      renderQuestionset(questions)
    })

    output$rnorm <- renderPlot({
      hist(main = "", xlab = "", ylab = "", rnorm(n = 1000, m = 24.2, sd = 2.2))
    })

    output$rlnorm <- renderPlot({
      hist(main = "", xlab = "", ylab = "", rlnorm(1000))
    })

    # Register events for question inputs
    registerQuestionEvents(session, questions)

    # Watch for submit button presses
    observeEvent(input$submit, {
      session$sendCustomMessage(type = 'create-statement', rlocker::createStatement())
    })
  }
)


