#' main UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_main_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' main Server Function
#'
#' @noRd 
mod_main_server <- function(input, output, session){
  ns <- session$ns
 
}
    
## To be copied in the UI
# 
    
## To be copied in the server
# callModule(mod_main_server, "main_ui_1")
 
