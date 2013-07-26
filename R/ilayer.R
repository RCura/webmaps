ilayer <- function(xyz,name,pfunc=colorRamp(c("white","black")),opacity=0.6,...){

  if(!.checkName(name)){
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

.writeOut.ilayer <- function(Layer,outputDir){
  name = Layer$name
  pnmFile = paste(name,".pnm",sep="")
  pngFile = paste(name,".png",sep="")
  pnmPath = file.path(outputDir,pnmFile)
  pngPath = file.path(outputDir,pngFile)
  cat(paste("//", pngPath, sep=""))
  rgb = Layer$pfunc(t(Layer$xyz$z)[ncol(Layer$xyz$z):1,])
  rgbpixmap = myPixmapRGB(c(rgb[,1],rgb[,2],rgb[,3]),ncol(Layer$xyz$z),nrow(Layer$xyz$z))
  write.pnm(rgbpixmap,file=pnmPath)
  xp=GDAL.open(pnmPath)
  xx=copyDataset(xp,driver="PNG")
  saveDataset(xx,pngPath)
  GDAL.close(xx)
  GDAL.close(xp)
  #file.remove(pnmPath)
}

.templatePart.ilayer <- function(x){
  system.file("templates/osmILayer.brew",package="webmaps")
}

myPixmapRGB <- function (data, ...) 
{
    z = new("pixmapRGB", pixmap(data, ...))
    datamax <- max(data)
    print(datamax)
    datamin <- min(data)
    print(datamin)
    data <- as.numeric(data)
    if (datamax > 1 || datamin < 0) {data <- (data - datamin)/(datamax - datamin)}
    data = array(data, dim = c(z@size[1], z@size[2], 3))
    z@red = matrix(data[, , 1], nrow = z@size[1], ncol = z@size[2])
    z@green = matrix(data[, , 2], nrow = z@size[1], ncol = z@size[2])
    z@blue = matrix(data[, , 3], nrow = z@size[1], ncol = z@size[2])
    z
}
