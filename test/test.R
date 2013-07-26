library(webmaps)

file.remove(Sys.glob(paths="./test/*.xsd"))
file.remove(Sys.glob(paths="./test/*.gml"))
file.remove(Sys.glob(paths="./test/index.html"))


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
       layer(layerData = state,
             name = "States2",
             lstyle(
                 pointRadius = 1,
                 fillColor = 'black',
                 strokeColor = "black",
                 fillOpacity = 1)),
       title="Test",
       htmlFile="index.html",
       browse=TRUE,
       toShiny=FALSE)

library(splancs)
pts = cbind(rnorm(100,0.5,.5),rnorm(100,53.5,.5))
pts = rbind(pts,cbind(rnorm(100,-1,.5),rnorm(100,52,.5)))
k = kernel2d(pts,sbox(pts),0.4,100,100)
kl = ilayer(k,name="density",colorRamp(c("blue","red")))
pts = data.frame(pts)
coordinates(pts) <- cbind(pts[,1],pts[,2])
ptsl = layer(pts,"Points",lstyle(pointRadius=3,fillColor="white",strokeColor="black"))
webmap(kl, ptsl,browse=TRUE)