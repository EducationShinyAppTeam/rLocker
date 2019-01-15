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
        )
      )
    )
  ),
  server = function(input, output, session) {
    rlocker::create(session, list(
      endpoint = "https://learning-locker.stat.vmhost.psu.edu/data/xAPI/",
      auth = "Basic NWE3NzBkOTNmNTlhMzM5NTI5YTI1ODgyYjgwMjExYTViNDVhYWNhMTo1NmY1MDQyYTczODU0ZTRkMThkNDQ0MDMwZTY2MWNhN2Q5OWM0ZmQ0"
    ))
    output$session <- renderPrint({
      sessionInfo()
    })
  }
)
