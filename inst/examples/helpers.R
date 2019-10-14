## Setup for demo application

# Set current user to var for convenience
currentUser <- connection$agent

# Render an individual question from a list
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

# Render full list of questions
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

# Render xAPI statement for demonstration purposes 
renderxAPIStatement <- function(session, question, statement){
  session$output$statements <- renderText({
    paste0(
      "<p>For <mark>&nbsp;", question$title, "&nbsp;</mark>, you chose: <mark>&nbsp;", session$input[[question$id]], "&nbsp;</mark>. The correct answer is: <mark>&nbsp;", question$answer,"&nbsp;</mark>.</p>
      <p>The following xAPI Statement has been generated:</p>
      <pre>", statement, "</pre>"
    )
  })
}

# Bind question input items to observers
registerQuestionEvents <- function(session, questions){
  observe({
    sapply(questions, function (question) {
      observeEvent(session$input[[question$id]], {
        statement <- rlocker::createStatement(
          list(
            agent = currentUser,
            verb = list(
              display = "answered"
            ),
            object = list(
              id = paste0(getCurrentAddress(session), "#", question$id),
              name = question$title,
              description = question$text,
              interactionType = "choice"
            ),
            result = list(
              success = session$input[[question$id]] == question$answer,
              response = session$input[[question$id]]
            )
          )
        )
        
        renderxAPIStatement(session, question, statement)
        
        # Store statement in locker and return status
        status <- rlocker::store(session, statement)
        
        # Render status code popup notification
        ifelse(
          status == 200,
          showNotification('Statement stored.', type = 'message'),
          showNotification('Failed to store statement.', type = 'error')
        )
      })
    })
  })
}

# Watch for submit button presses
observeEvent(input$submit, {
  session$sendCustomMessage(type = 'create-statement', rlocker::createStatement(list(actor = currentUser)))
})

# Gets current page address from the current session
getCurrentAddress <- function(session){
  return(paste0(
    session$clientData$url_protocol, "//",
    session$clientData$url_hostname,
    session$clientData$url_pathname, ":",
    session$clientData$url_port,
    session$clientData$url_search
  ))
}