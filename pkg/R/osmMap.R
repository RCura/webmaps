osmMap <-
function(layerList, title="map", outputDir=tempdir(), htmlFile="index.html", colours=palette(),browse=FALSE){

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

brewTemplate = system.file("templates/osmMap.brew",package="webmaps")

### check layer names
  nmk = names(layerList)
 
  ok = grep("^[a-z][a-z0-9_]*$",nmk)
  if(length(ok)!=length(nmk)){
    stop("First argument must be a list like: list(name=object,..) where the names are valid JavaScript identifiers (start with a letter, then alphanumerics).")
  }

  box = list(xmin = 180,xmax=-180,ymin=90,ymax=-90)
  
  colours = colorRampPalette(colours)(length(nmk))
  colours[1]
  for(i in seq_along(nmk)){
    layer = layerList[[i]]
    box = updateBbox(box,layer)
    name = nmk[i]
    gmlFile = paste(name,".gml",sep="")
    gmlPath = file.path(outputDir,gmlFile)
  
    writeOGR(layer,gmlPath,name,"GML")
  }
  outPath = file.path(outputDir,htmlFile)
  bounds = paste(box$xmin,box$ymin,box$xmax,box$ymax,sep=",")
  brew(file=brewTemplate,output=outPath)

  if(browse){
    browseURL(outPath)
  }
  
  return(outPath)

  
}

