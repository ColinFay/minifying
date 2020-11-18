#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  
  gargoyle::init("uploaded", "minified")
  # List the first level callModules here
  file <- FileManager$new()
  callModule(mod_left_server, "left_ui_1", file)
  callModule(mod_right_server, "right_ui_1", file)
}
