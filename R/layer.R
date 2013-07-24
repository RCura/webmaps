layer <- function(layerData, name, style=lstyle() ){

  if(!.checkName(name)){
    stop(paste("\"",name,"\" is invalid layer name",sep=""))
  }
  
  if(sum(names(style) != "") != length(style)){
    stop("Style parameter has no name")
  }
  
  layer <- list(data = layerData, name = name, style = style)

  layer$select = TRUE
  
  class(layer) <- "layer"
  return(layer)
}

print.layer <- function(x,...){
  cat("Map layer: ",x$name,"\n")
  cat("Data summary\n")
  print(summary(x$data))
  print(x$style)
  invisible(0)
}

.templatePart.layer <- function(x){
  system.file("templates/osmLayer.brew",package="webmaps")
}

geoJSONString <- function(Layer){
    name = Layer$name
    tmpOutputFile <- tempfile()
    writeOGR(obj=Layer$data,dsn=tmpOutputFile, layer=name, "GeoJSON")
    readChar(con=tmpOutputFile, nchars=file.info(tmpOutputFile)$size)
}