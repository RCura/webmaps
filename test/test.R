library(webmaps)


# layer test
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


# iLayer test
library(splancs)
testPoints <- cbind(rnorm(100,0.5,.5), rnorm(100,53.5,.5))
testPoints <- rbind(testPoints, cbind(rnorm(100,-1,.5), rnorm(100,52,.5)))
k2d <- kernel2d(pts=testPoints, poly=sbox(testPoints), h0=0.4, nx=100, ny=100, quiet=TRUE)
kLayer <- ilayer(k2d, name="density", colorRamp(c("blue", "red")))
testPoints <- data.frame(testPoints)
coordinates(testPoints) <- cbind(testPoints[,1], testPoints[,2])
pointsLayer <- layer(testPoints, "Points", lstyle(pointRadius=3, fillColor="white", strokeColor="black"))
webmap(kLayer, pointsLayer, browse=TRUE, toShiny=FALSE, outputDir='/home/robin/test/')


# Shiny test
abc <- webmap(layer(layerData = state,
             name = "States",
             lstyle(
                 pointRadius = '${Murder}',
                 fillColor = "${color}",
                 strokeColor = "black",
                 fillOpacity = 0.4)),
       title="Test",
       toShiny=TRUE)