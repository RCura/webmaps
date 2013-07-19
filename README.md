webmaps
=======

An R package for creating 'slippy web maps' from spatial data.
Easily create HTML pages that show your points, lines, and polygons on world map data.

* Author : **Barry Rowlingson**
* Maintainer : **Robin Cura**

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

osmMap ( layer ( state , "States" , style (
        pointRadius = '${Murder}',
        fillColor = "${color}" ,
        strokeColor = "black",
        fillOpacity = 0.4)),
    title = "State Data" ,
    outputDir = "./test/" )
```

** NB : This require a webserver due to cross-access restrictions **
