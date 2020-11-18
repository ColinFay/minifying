context("golem tests")

test_that("UI works", {
  if (interactive()){
    test <- crrry::CrrryProc$new(
      chrome_bin = pagedown::find_chrome(),
      # Process to launch locally
      fun = "options(golem.app.prod = FALSE);golem::document_and_reload();run_app()",
      # Note that you will need httpuv >= 1.5.2 for randomPort
      chrome_port = httpuv::randomPort(), 
      headless = FALSE
    )
    test$wait_for_shiny_ready()
    
    ext <- c("css", "js", "json", "html")
    
    for (i in 1:length(ext)){
      # Set the extension value
      test$shiny_set_input("left_ui_1-testingtext", ext[i])
      # Trigger the file to be read
      test$shiny_set_input("left_ui_1-testingtrigger", i)
      # Launch the minification
      test$shiny_set_input("left_ui_1-launch", i)
    }
    test$stop()
  }
})









