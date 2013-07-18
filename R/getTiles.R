### sample usage:
###  lancs =  getTiles(c(-2.842,-2.7579),c(54.0295,54.063),12,path="http://tile.openstreetmap.org/",maxTiles=60,verbose=TRUE)
###

.tile2boundingBox <- function(x,y,zoom){

  n = .tile2lat(y,zoom)
  s = .tile2lat(y+1,zoom)
  w = .tile2lon(x,zoom)
  e = .tile2lon(x+1,zoom)
  return(c(s,w,n,e))
  
}

.tile2lat <- function(y,zoom){
  n = pi - ((2.0 * pi * y) / (2.0^zoom))
  return ( 180.0 / pi * atan(0.5 * (exp(n) - exp(-n))))
}

.tile2lon <- function(x,zoom){
  return(((x/(2^zoom)*360)-180))
}


.lonlat2tile <- function(lon,lat,zoom){
  xtile = floor(((lon + 180) / 360) * 2^zoom)
  ytile = floor((1 - log(tan(lat*pi/180) + 1 / cos(lat*pi/180)) / pi) /2 * 2^zoom)
  return(c(xtile,ytile))
}

.getTileBounds <- function(xlim,ylim,zoom){
  LL = .lonlat2tile(xlim[1],ylim[1],zoom)
  UR = .lonlat2tile(xlim[2],ylim[2],zoom)
  return(list(LL,UR))
}

nTiles <- function(xlim,ylim,zoom){
  tb = .getTileBounds(xlim,ylim,zoom)
  nt = (tb[[2]][1]-tb[[1]][1]+1)*(tb[[1]][2]-tb[[2]][2]+1)
  return(nt)
}

getTilePaths <- function(xlim,ylim,zoom,path){
  tileBounds = .getTileBounds(xlim,ylim,zoom)
  LL = tileBounds[[1]]
  UR = tileBounds[[2]]
  tileData = list()
  i = 1
  for(I in LL[1]:UR[1]){
    for(J in LL[2]:UR[2]){
      tilePath = paste(path,paste(zoom,I,J,sep="/"),'.png',sep='')
      tileBounds = .tile2boundingBox(I,J,zoom)
      tileData[[i]]=list(path=tilePath,bounds=tileBounds,I=I,J=J,zoom=zoom,src=path)
      i = i + 1
    }
  }
  return(tileData)
}

getTiles <- function(xlim,ylim,zoom,path,maxTiles = 16,cacheDir=tempdir(),timeOut=5*24*60*60,verbose=FALSE){
  nt = nTiles(xlim,ylim,zoom)
  if(nt > maxTiles){
    stop("Cant get ",nt," tiles with maxTiles set to ",maxTiles)
  }
  tileData = getTilePaths(xlim,ylim,zoom,path)
  rasters = list()
  localStore = FALSE
  if(file.exists(path)){
    if(!file.info(path)$isdir){
      stop("Path ",path," is not a folder")
    }
    localStore = TRUE
  }
    
  for(ip in 1:length(tileData)){
    p = tileData[[ip]]$path
    if(localStore){
      where = p
    }else{
      where = .getTileCached(tileData[[ip]],cacheDir,timeOut=timeOut,verbose=verbose)
    }
    rasters[[ip]] = readGDAL(where,silent=!verbose)

    if(dim(rasters[[ip]])[2]==1){
      ## convert from indexed colour
      d = GDAL.open(where)
      rgb = col2rgb(getColorTable(d))
      GDAL.close(d)
      data = rasters[[ip]]@data$band1+1
      rasters[[ip]]@data = data.frame(band1=rgb[1,data],band2=rgb[2,data],band3=rgb[3,data])
    }
    
    swne = tileData[[ip]]$bounds
    rasters[[ip]]@grid@cellcentre.offset = swne[2:1]
    cellh = (swne[3]-swne[1]) / rasters[[ip]]@grid@cells.dim[2]
    cellw = (swne[4]-swne[2]) / rasters[[ip]]@grid@cells.dim[1]
    rasters[[ip]]@grid@cellsize = c(cellw,cellh)
    rasters[[ip]]@bbox = rbind(c(swne[2]-cellw/2,swne[4]+cellw/2),
                   c(swne[1]-cellh/2,swne[3]+cellh/2))
  }
  attr(rasters,"path") <- path
  class(rasters) <- "tiles"
  return(rasters)
}


print.tiles <- function(x,...){
  cat("Tiles from ",attr(x,'path'),"\n")
  cat("There are ",length(x)," tiles.\n")
  cat("Bounding box:\n")
  print(tileBbox(x))
}

tileBbox <- function(x){
    aboxes=array(unlist(lapply(x,bbox)),c(2,2,length(x)))
    cbind(c(min(aboxes[1,1,]),max(aboxes[1,2,])),c(min(aboxes[2,1,]),max(aboxes[2,2,])))
}
image.tiles <- function(x,...){
  dots = list(...)
  if(any(names(dots)=="add")){
    add <- dots$add
  }else{
    add=FALSE
  }
  if(!add){
    box = tileBbox(x)
    ycentre = mean(box[,2])
    asp = 1/cos(ycentre*pi/180)
    plot.default(box,type='n',axes=FALSE,xlab="",ylab="",asp=asp)
  }
  for(tile in x){
    image(tile,red=1,green=2,blue=3,add=TRUE)
  }
}

.getTileCached <- function(tileData,cacheDir,timeOut=30,verbose=FALSE){
  srcDir = paste("X",make.names(tileData$src),sep="")
  tileDir = paste(file.path(cacheDir,srcDir,tileData$zoom,tileData$I))
  tilePath = paste(file.path(tileDir,tileData$J),".png",sep="")
  retrieve = FALSE
  if(!file.exists(tilePath)){
    if(verbose)cat("Getting new tile\n")
    retrieve = TRUE
  }else{
    age = difftime(Sys.time(),file.info(tilePath)$mtime,units = "mins")
    if (age > timeOut){
      if(verbose)cat("Tile aged ",age," expired from cache\n")
      retrieve = TRUE
    }else{
      if(verbose){cat("Tile found in cache\n")}
    }
  }
  if(retrieve){
    if(verbose)cat("Downloading tile\n")
    dir.create(tileDir,recursive=TRUE,showWarnings=FALSE)
    p = tileData$path
    download.file(p,tilePath,mode="wb",quiet=!verbose)
  }
  
  return(tilePath)
}
