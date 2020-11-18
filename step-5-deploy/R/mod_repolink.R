#' repolink UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_repolink_ui <- function(id){
  ns <- NS(id)
  tagList(
    tags$div(
      class = "footerrepo", 
      tags$span(
        "To see the code source or report an issue, please go to: ", 
        tags$a(href = "https://github.com/ColinFay/minifying", "github.com/ColinFay/minifying", target = "_blank")
      )
    )
  )
}

#' repolink Server Function
#'
#' @noRd 
mod_repolink_server <- function(input, output, session){
  ns <- session$ns
  
}

## To be copied in the UI
# 

## To be copied in the server
# callModule(mod_repolink_server, "repolink_ui_1")

