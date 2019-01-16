library(shiny)
library(rlocker)

shinyApp(
  ui = fluidPage(

    # Application title
    titlePanel("rlocker demo"),

    fluidRow(
      column(12,
        h4("Session Info"),
        mainPanel(
          textOutput("session")
        ),
        hr()
      )
    ),
    fluidRow(
      column(1,
        actionButton("submit", "Test")
      )
    )
  ),
  server = function(input, output, session) {
    rlocker::connect(session, list(
      endpoint = "http://localhost:8000/data/xAPI/",
      auth = "Basic YWNjb3VudEBlbWFpbC5jb206c3VwZXJzZWNyZXRwYXNzd29yZA"
    ))
    output$session <- renderPrint({
      sessionInfo()
    })
    observeEvent(input$submit, {
      session$sendCustomMessage(type = 'create-statement', rlocker::createStatement())
    })
  }
)
