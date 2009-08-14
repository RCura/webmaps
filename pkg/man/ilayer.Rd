\name{ilayer}
\Rdversion{1.1}
\alias{ilayer}
\alias{print.ilayer}
\title{
Create a raster layer object.
}
\description{
Create an object for a raster overlay on a map.
}
\usage{
ilayer(xyz, name, pfunc = colorRamp(c("white", "black")), opacity=0.6,\dots)
\method{print}{ilayer}(x,\dots)
}
\arguments{
  \item{xyz}{
    A list with x, y, and z components. Lengths of x and y must equal
    the dimensions of the z matrix. Coordinates must be in WGS84 lat-long.
  }
  \item{name}{
    An identifier for the data. Must be a valid Javascript label.
  }
  \item{pfunc}{
    A function that maps values to colours.
  }
  \item{opacity}{
    The opacity level for the map (0 = transparent, 1 = opaque).
  }
  \item{\dots}{
    Extra arguments, unused at the moment...
  }
  \item{x}{
    An ilayer object
    }
}
\details{
This function just copies the data and wraps it up with a name and the
colour map function.
}
\value{
An object of class 'ilayer'.
}
\author{
Barry Rowlingson
}
\examples{

xyz =
list(x=seq(0,1,len=10),y=seq(53,54,len=10),z=matrix(runif(100),10,10))

l2 = ilayer(xyz,"randomField",colorRamp(c("white","red")),opacity=0.2)

}
\keyword{hplot}

