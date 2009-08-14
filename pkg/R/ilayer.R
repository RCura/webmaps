ilayer <- function(xyz,name,pfunc=colorRamp(c("white","black")),opacity=0.6,...){

  if(!checkName(name)){
    stop(paste("Invalid name: ",name,sep=""))
  }

  layer = list()

  layer$xyz = xyz
  layer$name = name

  ### this is useful for it's bbox
  xw = diff(range(xyz$x))/(length(xyz$x)-1)
  yw = diff(range(xyz$y))/(length(xyz$y)-1)
  layer$data = SpatialPoints(cbind(range(xyz$x)+c(-xw/2,xw/2),range(xyz$y)+c(-yw/2,yw/2)))
  
  layer$pfunc = pfunc
  layer$opacity=opacity
  layer$extra = list(...)

  layer$select = FALSE
  
  class(layer) <- c("ilayer")
  return(layer)
  
}

print.ilayer <- function(x,...){
  cat("Image Layer: ",x$name,"\n")
  cat(length(x$xyz$x),"x",length(x$xyz$y)," pixels.\n")
}

writeOut.ilayer <- function(Layer,outputDir){
  name = Layer$name
  tiffFile = paste(name,".tif",sep="")
  pngFile = paste(name,".png",sep="")
  tiffPath = file.path(outputDir,tiffFile)
  pngPath = file.path(outputDir,pngFile)
  
  rgb = Layer$pfunc(Layer$xyz$z)
  rgb = Layer$pfunc(t(Layer$xyz$z)[ncol(Layer$xyz$z):1,])
  rgbpixmap = pixmapRGB(c(rgb[,1],rgb[,2],rgb[,3]),ncol(Layer$xyz$z),nrow(Layer$xyz$z))
  writeTiff(rgbpixmap,tiffPath)
  xp=GDAL.open(tiffPath)
  xx=copyDataset(xp,driver="PNG")
  saveDataset(xx,pngPath)
  GDAL.close(xx)
  GDAL.close(xp)
  file.remove(tiffPath)
}

templatePart.ilayer <- function(x){
  system.file("templates/osmILayer.brew",package="webmaps")
}
