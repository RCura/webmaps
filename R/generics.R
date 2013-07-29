
.writeOut <- function(Layer,outputDir){
  UseMethod(".writeOut")
}

.geoJSONString <- function(Layer){
    UseMethod(".geoJSONString")
}

.templatePart <- function(x){
  UseMethod(".templatePart")
}