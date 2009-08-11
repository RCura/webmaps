layer <- function(layerData,name,...){

  okName = grep("^[a-z][a-z0-9_]*$",name)
  if(length(okName)==0){
    stop(paste("\"",name,"\" is invalid layer name",sep=""))
  }
  
  style = list(...)
  if(sum(names(style)!="")!=length(style)){
    stop("Style parameter has no name")
  }
  
  l = list(data = layerData,
    name = name,
    style = style
    )

  class(l) <- "layer"
  return(l)
}

print.layer <- function(x,...){
  cat("Map layer: ",x$name,"\n")
  cat("Data summary\n")
  print(summary(x$data))
  cat("Style\n")
  print(x$style)
  invisible(0)
}
