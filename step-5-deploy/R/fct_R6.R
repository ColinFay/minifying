#' R6 Class for managing the file 
#' 
#' @noRd
FileManager <- R6::R6Class(
  "FileManager", 
  public = list(
    original_file = NULL, 
    minified_file = NULL, 
    original_name = NULL,
    type = NULL,
    minifier = NULL,
    mcompress = NULL,
    initialize = function(){
      self$mcompress <- memoise::memoize(compress)
    },
    add_new_file = function(
      file
    ){
      self$original_file <- file
    }, 
    guess_minifier = function(){
      self$minifier <- guess_minifier(
        self$original_file
      )
    }, 
    compress = function(selection){
      self$minified_file <- self$mcompress(
        self$minifier, 
        selection
      )
    }, 
    compare = function(){
      compare(
        self$original_file,
        self$minified_file
      )
    }
  )
  
)