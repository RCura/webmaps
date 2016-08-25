webmaps
=======

## This package development is discontinued due to better and more maintained packages.
## For webmapping, check [leaflet](https://rstudio.github.io/leaflet/), [leafletR](https://github.com/chgrl/leafletR) and [mapview](https://github.com/environmentalinformatics-marburg/mapview).
## If you need to use OpenLayers from R, [OpenStreetMapR](http://greentheo.github.io/OpenStreetMapR/) seems the best deal.

An R package for creating 'slippy web maps' from spatial data.
Easily create HTML pages that show your points, lines, and polygons on world map data.

* Author : **Barry Rowlingson**
* Maintainer : **Robin Cura**

![webmaps screenshot](https://raw.github.com/RCura/webmaps/master/img/webmaps_screenshot.png)

## Setup
This package can be installed using the `devtools` package, running :
```R
require(devtools)
install_github(repo = "webmaps", username = "RCura")
```

## Usage
```R
library(webmaps)
state <- data.frame(state.x77)
state$Name <- rownames(state)
state$color <- strtrim(rainbow(n=nrow(state)), 7)
coordinates(state) <- cbind(state.center$x, state.center$y)

webmap(layer(layerData = state,
             name = "States",
             lstyle(
                 pointRadius = '${Murder}',
                 fillColor = "${color}",
                 strokeColor = "black",
                 fillOpacity = 0.4)),
       title="Test",
       htmlFile="index.html",
       browse=TRUE,
       toShiny=FALSE)
```
