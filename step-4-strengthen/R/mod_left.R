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
  file
){
  ns <- session$ns
  
  golem::invoke_js("disableid", list(id = ns("dl")))
  
  observeEvent( input$upload , {
    if (
      # We are double-checking the extension, so that we are sure people messing 
      # with the UI won't be able to upload other type of files
      tolower(tools::file_ext(input$upload$datapath)) %in% c("js", "html", "css", "json")
    ) {
      # Use loaded_ to store our guess
      file$original_file <- input$upload$datapath
      file$guess_minifier()
      file$type <- input$upload$type
      file$minified_file <- NULL
      file$original_name <- input$upload$name
      gargoyle::trigger("uploaded")
      golem::invoke_js("disableid", list(id = ns("dl")))
    } else {
      # show a notif if the file isn't loaded
      showNotification(
        "Unable to load your file", 
        type = "error"
      )
    }
  })
  
  observeEvent( input$testingtrigger , {
    if (golem::app_dev()){
      file$original_file <- minifyr::minifyr_example(ext = input$testingtext)
      file$guess_minifier()
      file$type <- input$upload$type
      file$minified_file <- NULL
      file$original_name <- input$upload$name
      gargoyle::trigger("uploaded")
    }
  
  })
  
  
  
  observeEvent( gargoyle::watch("uploaded") , {
    updateSelectInput(
      session,
      "algo",
      choices = file$minifier$functions
    )
  })
  
  observeEvent( input$launch , {
    withProgress(
      message = "Minification in  progress", 
      file$compress(input$algo)
    )
    gargoyle::trigger("minified")
    golem::invoke_js("undisableid", list(id = ns("dl")))
  })
  
  output$gain <- renderUI({
    gargoyle::watch("minified")
    req(file$original_file)
    req(file$minified_file)
    res <- file$compare()
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
      paste(tools::file_path_sans_ext(file$original_name), '-minified.', file$type, sep='')
    },
    content = function(con) {
      write(file$minified_file, con)
    },
    contentType =  file$type
  )
  
  
}

## To be copied in the UI
# 

## To be copied in the server
# 

