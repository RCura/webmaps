\name{lstyle}
\Rdversion{1.1}
\alias{lstyle}
\alias{print.lstyle}
\alias{OLStyle}
\title{
Define styles for map layers
}
\description{
Create and manipulate style (colors, markers, outlines etc) for map layers.
}
\usage{
lstyle(...)
\method{print}{lstyle}(x,\dots)
OLStyle(x)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{\dots}{
 Named style parameters, as documented in the OpenLayers
 documentation - or see the source code (just type 'lstyle' at the R prompt)
 for valid names.
}
  \item{x}{A layer style object as returned by lstyle()}
}
\details{
Map layers are styles using layer styles.
}
\value{
lstyle returns a list with the style names and values. The names are
checked for correctness.

OLStyle returns a chunk of Javascript for using a layer style in
OpenLayers. It's not really a user-level function.}

\author{
Barry Rowlingson
}

\examples{
l1 = lstyle()
l2 = lstyle(fillColor="red", fillOpacity="0.5")
l3 = lstyle(pointRadius="${size}")
OLStyle(l3)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{hplot}
