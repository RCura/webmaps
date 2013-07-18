.checkName <- function(name){
  okName = grep("^[a-zA-Z][a-zA-Z0-9_]*$", name)
  if (length(okName) == 0) {
    return(FALSE)
  }
  return(TRUE)
}
