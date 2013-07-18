layer <- function(layerData,name,style=lstyle()){

  
  if(!.checkName(name)){
    stop(paste("\"",name,"\" is invalid layer name",sep=""))
  }
  
  if(sum(names(style)!="")!=length(style)){
    stop("Style parameter has no name")
  }
  
  l = list(data = layerData,
    name = name,
    style = style
    )

  l$select = TRUE
  
  class(l) <- "layer"
  return(l)
}

print.layer <- function(x,...){
  cat("Map layer: ",x$name,"\n")
  cat("Data summary\n")
  print(summary(x$data))
  print(x$style)
  invisible(0)
}

.writeOut.layer <- function(Layer,outputDir){
  name = Layer$name
  gmlFile = paste(name, ".gml", sep = "")
  gmlPath = file.path(outputDir, gmlFile)
  writeOGR(Layer$data, gmlPath, name, "GML")
}

.templatePart.layer <- function(x){
  system.file("templates/osmLayer.brew",package="webmaps")
}
