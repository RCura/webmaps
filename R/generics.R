
.writeOut <- function(Layer,outputDir){
  UseMethod(".writeOut")
}

.geoJSONString <- function(Layer){
    UseMethod(".geoJSONString")
}

.templatePart <- function(x){
  UseMethod(".templatePart")
}

.geoJSONtemplatePart <- function(x){
    UseMethod(".geoJSONtemplatePart")
}

.toShiny <- function(Layer){
    UseMethod('.toShiny')
}