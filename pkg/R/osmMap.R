
osmMap <-
function(..., title="map", outputDir=tempdir(), htmlFile="index.html", browse=FALSE){

  require(brew)
  require(sp)
  require(rgdal)

updateBbox=function(box,layer){
  bb = bbox(layer)
  box$xmin = min(box$xmin,bb[1,1])
  box$xmax = max(box$xmax,bb[1,2])
  box$ymin = min(box$ymin,bb[2,1])
  box$ymax = max(box$ymax,bb[2,2])
  return(box)
}

  Layers = list(...)
  
  mapTemplate = system.file("templates/osmMap.brew",package="webmaps")
  layerTemplate = system.file("templates/osmLayer.brew",package="webmaps")

  box = list(xmin = 180,xmax=-180,ymin=90,ymax=-90)

  selectable = c()
  for(Layer in Layers){
    box = updateBbox(box,Layer$data)
    writeOut(Layer,outputDir)
    if(Layer$select){
      selectable=c(selectable,Layer$name)
    }
  }

  selectList = paste(selectable,collapse=",")
  
  outPath = file.path(outputDir,htmlFile)
  bounds = paste(box$xmin,box$ymin,box$xmax,box$ymax,sep=",")
  brew(file=mapTemplate,output=outPath)

  if(browse){
    browseURL(outPath)
  }
  
  return(outPath)

  
}

