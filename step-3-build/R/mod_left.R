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
              ".html"
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
  
  golem::invoke_js("disableid", list(id = ns("dl")))
  
  observeEvent( input$upload , {
    if (
      # We are double-checking the extension, so that we are sure people messing 
      # with the UI won't be able to upload other type of files
      tolower(tools::file_ext(input$upload$datapath)) %in% c("js", "html", "css", "json")
    ) {
      #browser()
      # Use loaded_ to store our guess
      r$loaded_ <- guess_minifier(input$upload$datapath)
      r$original_name <- input$upload$name
      r$type <- input$upload$type
      r$minified_ <- NULL
      golem::invoke_js("disableid", list(id = ns("dl")))
    } else {
      # show a notif if the file isn't loaded
      showNotification(
        "Unable to load your file", 
        type = "error"
      )
    }
  })
  
  observeEvent(r$loaded_, {
    req(r$loaded_$functions)
    updateSelectInput(
      session, 
      "algo", 
      choices = r$loaded_$functions
    )
  })
  
  
  observeEvent( input$launch , {
    r$minified_$file <- compress(
      r$loaded_,
      input$algo
    )
    golem::invoke_js("undisableid", list(id = ns("dl")))
  })
  
  output$gain <- renderUI({
    req(r$loaded_$file)
    req(r$minified_$file)
    #browser()
    res <- compare(
      r$loaded_$file,
      r$minified_$file
    )
    if (!grepl("B", res)){
      res <- sprintf("%sB", res)
    }
    tags$p(
      align = "center",
      sprintf(
        "You've gain %s \U0001f389", 
        res
      )
    )
  })
  
  output$dl <- downloadHandler(
    filename = function() {
      paste(tools::file_path_sans_ext(r$original_name), '-minified.', r$loaded_$ext, sep='')
    },
    content = function(con) {
      write(r$minified_$file, con)
    }, 
    contentType = r$type
  )
  

}

## To be copied in the UI
# 

## To be copied in the server
# 

