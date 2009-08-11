style <- function(...){

  properties = c(
    "fillColor",
    "fillOpacity",
    "strokeColor",
    "strokeOpacity",
    "strokeWidth",
    "strokeLinecap",
    "strokeDashstyle",
    "pointRadius",
    "externalGraphic",
    "graphicWidth",
    "graphicHeight",
    "graphicOpacity",
    "graphicXOffset",
    "graphicYOffset",
    "graphicName"
    )

  args = list(...)

  m = match(names(args),properties)
  if(any(is.na(m))){
    stop(paste("Unrecognised parameters: ",paste(names(args)[is.na(m)],sep="",collapse=",")))
  }
  class(args)="style"
  return(args)
    
}

print.style <- function(x,...){
  kv=c()
  for(k in names(x)){
    kv = c(kv,paste(k,"=\"",x[[k]],"\"",sep=""))
  }
  kkv = paste(kv,collapse=",")
  cat("Style:\n")
  cat(kkv)
  cat("\n")
  
}

OLStyle <- function(x){
  s = "new OpenLayers.Style(OpenLayers.Util.applyDefaults({"
  kv = c()
  for(k in names(x)){
    kv = c(kv,paste("'",k,"': '",x[[k]],"'",sep=""))
  }
  kkv = paste(kv,collapse=",\n")
  s=paste(s,kkv,"\n",sep="")
  s=paste(s,"},OpenLayers.Feature.Vector.style['default']))\n",sep="")
  return(s)
}


## ==
## This works to style layers by attributes:
  
##       var trees = new OpenLayers.Layer.GML("trees","trees.gml",{
##         projection: new OpenLayers.Projection("EPSG:4326"),
##         styleMap: new OpenLayers.Style({
##       'pointRadius': "${IRMmin}"
## })
##        });

## ===

# this does the override properly:
## styleMap: new OpenLayers.Style(
##  OpenLayers.Util.applyDefaults({'fillColor': 'red'}, OpenLayers.Feature.Vector.style['default'])
