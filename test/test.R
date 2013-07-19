library(webmaps)

file.remove(Sys.glob(paths="./test/*.xsd"))
file.remove(Sys.glob(paths="./test/*.gml"))
file.remove(Sys.glob(paths="./test/index.html"))


state <- data.frame(state.x77)
state$Name <- rownames(state)
coordinates(state) <- cbind(state.center$x, state.center$y)

osmMap ( layer ( state , "States" ,
                 lstyle (pointRadius = '${Murder}',
                         fillColor = "${Frost}" ,
                         strokeColor = "black",
                         fillOpacity = 0.4)
                 ),
title = "State Data" ,
         outputDir = "./test/" )

