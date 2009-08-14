\name{layer}
\Rdversion{1.1}
\alias{layer}
\alias{print.layer}
\title{
Create a map vector layer object.
}
\description{
Create a map vector layer object for some data and an optional
style. The data can be points, lines, or polygons.
}
\usage{
layer(layerData, name, style = lstyle())
\method{print}{layer}(x,\dots)
}
\arguments{
  \item{layerData}{
    An sp-class object, such as a SpatialPointsDataFrame
  }
  \item{name}{
    An identifier for the data. Must be a valid Javascript label.
  }
  \item{style}{
    A style object.
  }
  \item{x}{
    A layer object
  }
  \item{\dots}{
    Arguments to the print method.
  }
}
\details{
This function just copies the data and wraps it up with a name and a style.
}
\value{
An object of class 'layer'.
}
\author{
Barry Rowlingson
}
\examples{

data = data.frame(a=1:10,b=1:10)
coordinates(data)=cbind(runif(10,0,1),runif(10,53,54))

l1 = layer(data,name="myData",
   style=lstyle(fillColor="red", pointRadius="${a}"))

}
\keyword{hplot}

