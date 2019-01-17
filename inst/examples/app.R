library(shiny)
library(rlocker)

# Question Bank
questions = list(
  "question_1" = list(
    title = "Question 1",
    text = "What type of histogram is this?",
    type = "radio",
    choices = c("Normal" = "rnorm", "Uniform" = "unif", "Log-normal" = "lnorm", "Exponential" = "exp"),
    answer = "rnorm"
  ),
  "question_2" = list(
    title = "Question 2",
    text = "What type of histogram is this?",
    type = "radio",
    choices = c("Normal" = "rnorm", "Uniform" = "unif", "Log-normal" = "lnorm", "Exponential" = "exp"),
    answer = "lnorm"
  )
)

class(questions) <- "questionset"

shinyApp(
  ui = fluidPage(

    # Application title
    titlePanel("rlocker demo"),
    hr(),

    # Begin Quiz Questions
    fluidRow(
      tags$ol(
        tags$li(
          column(7, tags$div(
            tags$strong(questions$`1`$title),
            p(questions$`1`$text),
            plotOutput(questions$`1`$answer, width = "500px")
          )),
          column(4, tags$div(
            radioButtons("question_1", "Please select:", questions$`1`$choices)
          ))
        )
      )
    ),
    actionButton("submit", "Submit"),
    hr(),
    tags$samp(
      htmlOutput("statements")
    )
  ),
  server = function(input, output, session) {
    rlocker::connect(session, list(
      endpoint = "http://localhost:8000/data/xAPI/",
      auth = "Basic YWNjb3VudEBlbWFpbC5jb206c3VwZXJzZWNyZXRwYXNzd29yZA"
    ))

    output$rnorm <- renderPlot({
      hist(main = "", xlab = "", ylab = "", rnorm(n=1000, m=24.2, sd=2.2))
    })

    # Watch for input changes
    observeEvent(reactiveValuesToList(input), {
      output$statements <- renderText({
        paste("<p>For <mark>", questions$`1`$title, "</mark>, you chose: <mark>", input$question_1, "</mark>.</p>
              <p>The following xAPI Statement has been generated:</p>
              <pre>",
              rlocker::createStatement(
                list(
                  verb = "answered",
                  object = list(
                    name = questions$`1`$title,
                    description = questions$`1`$text
                  )
                )
              ),
              "</pre>"
        )
      })
    }, ignoreInit = TRUE) # use ignore init to prevent this from firing on page load

    # Watch for submit button presses
    observeEvent(input$submit, {
      session$sendCustomMessage(type = 'create-statement', rlocker::createStatement())
    })
  }
)

