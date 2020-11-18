#' left UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_left_ui <- function(id){
  ns <- NS(id)
  tagList(
    tags$div(
      class = "left split", 
      tags$div(
        class = "twenty", 
        tags$div(
          class = "innerdiv",
          align = "center",
          h2("Welcome to {minifying}!")
        )
      ), 
      tags$div(
        class = "twenty", 
        tags$div(
          class = "innerdiv",
          align = "center",
          fileInput(
            ns("upload"), 
            "Upload your file", 
            accept = c(
              "application/json", 
              "text/css",
              "application/javascript", 
              "application/xhtml+xml"
            )
          )
        )
      ), 
      tags$div(
        class = "twenty",
        align = "center", 
        tags$div(
          class = "innerdiv",
          selectInput(
            ns("algo"), 
            "Select a minifiers", 
            choices = NULL
          ), 
          tags$span(
            tags$span("Click "),
            tags$a(
              href = "https://node-minify.2clics.net/", 
              target = "_blank",
              "here"
            ),
            tags$span(" to learn more about the minifiers.")
          )
        )
      ), 
      tags$div(
        class = "twenty", 
        tags$div(
          class = "innerdiv",
          align = "center",
          actionButton(
            ns("launch"), 
            "Launch the minification"
          )
        ), 
        uiOutput(ns("gain"))
      ), 
      tags$div(
        class = "twenty", 
        tags$div(
          class = "innerdiv",
          align = "center",
          downloadButton(
            ns("dl"), 
            "Download the output"
          )
        )
      )
    )
  )
}

#' left Server Function
#'
#' @noRd 
mod_left_server <- function(
  input, 
  output, 
  session, 
  r
){
  ns <- session$ns
  
  observeEvent( input$launch , {
    r$text <-  shinipsum::random_text(
      nwords = 1000, 
      offset = sample(100:1000, 1)
    )
  })
  
  output$gain <- renderUI({
    req(input$launch)
    tags$p(
      align = "center",
      sprintf(
        "You've gain %s \U0001f389", 
        sample(100:1000, 1)
      )
    )
  })
  
  
  observeEvent(TRUE, {
    updateSelectInput(
      session, 
      "algo", 
      choices = LETTERS[1:10]
    )
  })
  
  
}

## To be copied in the UI
# 

## To be copied in the server
# 

