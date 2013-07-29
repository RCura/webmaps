
 webmapTags <- function(){
   list(tags$script(src="http://www.openlayers.org/api/OpenLayers.js", type="text/javascript"),
       tags$script(src="http://www.openstreetmap.org/openlayers/OpenStreetMap.js", type="text/javascript")) 
}

webmap <- function(..., title="map", outputDir=tempdir(), htmlFile="index.html", browse=FALSE, toShiny= FALSE){
    require(brew)
    require(sp)
    require(rgdal)
    if (toShiny) {require(shiny)}
    
    updateBbox <- function(box,layer){
        bb <- bbox(layer)
        box$xmin <- min(box$xmin,bb[1,1])
        box$xmax <- max(box$xmax,bb[1,2])
        box$ymin <- min(box$ymin,bb[2,1])
        box$ymax <- max(box$ymax,bb[2,2])
        
        return(box)
    }
    
    Layers = list(...)
    if (!toShiny){
        mapTemplate <- system.file("templates/osmMap.brew",package="webmaps")
    } else {
        mapTemplate <- system.file("templates/osmShinyMap.brew", package="webmaps")
    }
    layerTemplate <- layerTemplate <- system.file("templates/osmGeoJSONLayer.brew", package="webmaps")
    box <- list(xmin = 180,xmax=-180,ymin=90,ymax=-90)
    
    #### Layer writing ####
    
    selectable <- c()
    for(Layer in Layers){
        box <- updateBbox(box,Layer$data)
        if(Layer$select){
            selectable <- c(selectable,Layer$name)
        }
    }
    
    selectList <- paste(selectable,collapse=",")
    outPath <- file.path(outputDir,htmlFile)
    bounds <- paste(box$xmin,box$ymin,box$xmax,box$ymax,sep=",")
    
    
    if (!toShiny) {
        brew(file=mapTemplate, output=outPath)
        if (browse) {
            browseURL(outPath)  
        }
        return(outPath)
    } else {
        brew(mapTemplate, output=textConnection("outputObj", open="w"))
        return(outputObj)
    }
}
