#' Run the Shiny Application
#'
#' @param ... A series of options to be used inside the app.
#'
#' @export
#' @importFrom shiny shinyApp
#' @importFrom golem with_golem_options
#' @importFrom withr with_options
#' @importFrom minifyr node_available minifyr_npm_install
run_app <- function(
  ...
) {
  with_options(
    c("warn" = 2), {
      node_available()
    }
  )

  if (!dir.exists(
    file.path(
      system.file("node", package = "minifyr"),
      "node_modules"
    )
  )){
    minifyr_npm_install(force = TRUE)
  }



  with_golem_options(
    app = shinyApp(
      ui = app_ui, 
      server = app_server
    ), 
    golem_opts = list(...)
  )
}
