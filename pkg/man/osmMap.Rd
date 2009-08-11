\name{osmMap}
\Rdversion{1.1}
\alias{osmMap}

\title{
Create an OpenStreetMap view of Spatial Data
}
\description{
Take some sp-class objects (SpatialPointsDataFrame, SpatialPolygonsDataFrame etc) and create an OpenLayers map using OpenStreetMap background data.
}
\usage{
osmMap(..., title = "map", outputDir = tempdir(), htmlFile = "index.html", browse = FALSE)
}
\arguments{
  \item{...}{
Some layer objects
}
  \item{title}{
The map title.
}
  \item{outputDir}{
Where to put the html and data files.
}
  \item{htmlFile}{
The name of the html file.
}
  \item{browse}{
If TRUE, open R's default web browser on completion.
}
}
\details{
All spatial data must be in EPSG:4326 coordinates - this is also WGS84, and is
the most common lat-long system used by GPS and other web mapping systems.
}
\value{
  The path to the HTML file. Open this in your favourite browser. You need
  a browser with good JavaScript and SVG support.
}
\author{
Barry Rowlingson
}

\examples{
# create a spatial points data frame from the state data:
statesp = data.frame(state.x77)
statesp$Name = row.names(statesp)
coordinates(statesp) = cbind(state.center$x,state.center$y)
# how to produce three layers:
osmMap(layer(statesp[state.center$x < -109,],name="state1",fillColor="red"),
       layer(statesp[state.center$x >= -109 & state.center$x < -84,],
             name="state2",fillColor="blue",fillOpacity=0.5),
       layer(statesp[state.center$x > -84,],name="state3"))
}

\keyword{hplot}
