favicon <- function (
  ico = "favicon", 
  rel = "shortcut icon", 
  resources_path = "www", 
  ext = "ico"
) 
{
  ico <- fs::path(resources_path, ico, ext = ext)
  tags$head(tags$link(rel = rel, href = ico))
}