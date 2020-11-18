#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  
  # List the first level callModules here
  r <- reactiveValues(
    text = shinipsum::random_text(nwords = 1000)
  )
  callModule(mod_left_server, "left_ui_1", r)
  callModule(mod_right_server, "right_ui_1", r)
}
