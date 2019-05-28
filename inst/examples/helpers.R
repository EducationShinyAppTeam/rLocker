## Setup for demo application

# Question Bank
questions = list(
  list(
    id = "question_1",
    title = "Question 1",
    text = "What type of histogram is this?",
    type = "radio",
    choices = c("Log-normal (rlnorm)" = "rlnorm", "Uniform (unif)" = "unif", "Normal (rnorm)" = "rnorm", "Exponential (exp)" = "exp"),
    answer = "rnorm"
  ),
  list(
    id = "question_2",
    title = "Question 2",
    text = "What type of histogram is this?",
    type = "radio",
    choices = c("Normal (rnorm)" = "rnorm", "Uniform (unif)" = "unif", "Log-normal (rlnorm)" = "rlnorm", "Exponential (exp)" = "exp"),
    answer = "rlnorm"
  )
)

renderQuestion <- function(question){
  return(
    tagList(
      fluidRow(
        column(7, tags$div(
          tags$strong(question$title),
          p(question$text),
          plotOutput(question$answer, width = "500px")
        )),
        column(4, tags$div(
          radioButtons(question$id, "Please select:", question$choices, selected = FALSE)
        ))
      )
    )
  )
}

renderQuestionset <- function(questions){
  listItems = tagList()

  for(i in questions){
    listItems <- tagList(listItems, tags$li(renderQuestion(i)))
  }

  return(
    tagList(
      tags$ol(
        listItems
      )
    )
  )
}

renderxAPIStatement <- function(session, question){
  session$output$statements <- renderText({
    paste0(
      "<p>For <mark>", question$title, "</mark>, you chose: <mark>", session$input[[question$id]], "</mark>. The correct answer is: <mark>", question$answer,"</mark>.</p>
       <p>The following xAPI Statement has been generated:</p>
       <pre>",
          rlocker::createStatement(
            list(
              verb = "answered",
              object = list(
                name = question$title,
                description = question$text
              ),
              result = list(
                success = session$input[[question$id]] == question$answer,
                response = session$input[[question$id]]
              )
            )
          ),
      "</pre>"
    )
  })
}

registerQuestionEvents <- function(session, questions){
  observe({
    sapply(questions, function (question) {
      observeEvent(session$input[[question$id]], {
        renderxAPIStatement(session, question)
      })
    })
  })
}

getCurrentAddress <- function(session){
  return(paste0(
    session$clientData$url_protocol, "//",
    session$clientData$url_hostname,
    session$clientData$url_pathname, ":",
    session$clientData$url_port, "/",
    session$clientData$url_search
  ))
}
