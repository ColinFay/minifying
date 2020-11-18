#' Guess Minifier, Compress, and Compare
#'
#' @param file The file input, to be minified
#' @param input The file path
#' @param algo The output of `guess_minifier()`
#' @param selection The selected minifier
#' @param original The original file
#' @param minified The file to compare the size with
#'
#' @rdname minifyer
#' @import minifyr
#' @noRd
#' 
#' @note See the minifying.Rmd Vignette for more info
guess_minifier <- function(
  file
){
  # We'll start by getting the file extension
  ext <- tools::file_ext(file)
  # Check that the extension is correct, if not, return early
  # It's important to do this kind of check also on the server side 
  # As HTML manual tempering would allow to also send other type of files
  if (
    ! ext %in% c("js", "css", "html", "json")
  ){
    # Return early
    return(list())
  }
  # We'll then retrieve the available pattern based on the extension
  patt <- switch(
    ext, 
    js = "minifyr_js_.+",
    html = "minifyr_html_.+",
    css = "minifyr_css_.+",
    json = "minifyr_json_.+"
  )
  # List all the available functions to minify the file
  list(
    file = file,
    ext = ext,
    # We return this pattern so that it will be used to update the selectInput that 
    # is used to select an algo
    pattern = patt, 
    functions = grep(patt, names(loadNamespace("minifyr")), value = TRUE)
  )
  
}

compress <- function(algo, selection){
  # Creating a tempfile using our algo object
  tps <- tempfile(fileext = sprintf(".%s", algo$ext))
  # Getting the function with the selection
  converter <- get(
    grep(selection, algo$functions, value = TRUE)
  )
  # Do the conversion
  converter(algo$file, tps)
  # Return the temp file
  return(tps)
}

compare <- function(original, minified){
  # Get the file size of both
  original <- fs::file_info(original)$size
  minified <- fs::file_info(minified)$size
  return(original - minified)
}