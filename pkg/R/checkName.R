checkName <- function(name){
  okName = grep("^[a-z][a-z0-9_]*$", name)
  if (length(okName) == 0) {
    return(FALSE)
  }
  return(TRUE)
}
