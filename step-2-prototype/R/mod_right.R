#' right UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_right_ui <- function(id){
  ns <- NS(id)
  tagList(
    tags$div(
      class = "right split", 
      tags$div(
        class = "fifty", 
        tags$div(
          class = "innerdiv",
          tags$div(
            class = "",
            tags$h4("Original content"),
            textOutput(ns("original")) %>%
              tagAppendAttributes(
                class = "fixed"
              )
          )
        )
      ), 
      tags$div(
        class = "fifty", 
        tags$div(
          class = "innerdiv",
          tags$div(
            class = "",
            tags$h4("Minified content"),
            textOutput(ns("minified")) %>%
              tagAppendAttributes(class = "fixed")
          )
        )
      )
    )
  )
}

#' right Server Function
#'
#' @noRd 
mod_right_server <- function(
  input, 
  output, 
  session, 
  r
){
  ns <- session$ns
  
  output$original <- renderPrint({
    cat(r$text)
  })
  
  output$minified <- renderPrint({
    cat(gsub(" ", "", r$text))
  })
  
}

## To be copied in the UI
# 

## To be copied in the server
# 

