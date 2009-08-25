\name{getTiles}
\Rdversion{1.1}
\alias{getTiles}
\alias{getTilePaths}
\alias{print.tiles}
\alias{image.tiles}
\alias{tileBbox}
\alias{nTiles}
\title{
Get tiles from a tile server
}
\description{
  These are functions for loading and displaying map tiles from a tile server or
  a local cache of tiles.
}
\usage{
getTiles(xlim,ylim,zoom,path,maxTiles=16,cacheDir=tempdir(),timeOut=5*24*60*60,verbose=FALSE)
getTilePaths(xlim,ylim,zoom,path)
nTiles(xlim,ylim,zoom)
tileBbox(x)
\method{print}{tiles}(x,\dots)
\method{image}{tiles}(x,\dots)
}
\arguments{
  \item{xlim}{
    Length-2 vector of min and max X coordinate (latitude)
  }
  \item{ylim}{
    Length-2 vector of min and max Y coordinate (longitude)
  }
  \item{path}{
    URL of root directory of tile server, or file path to a local tile store.
  }
  \item{zoom}{
    Zoom level
  }
  \item{maxTiles}{
    Limit on the number of tiles to get, to avoid sending too many
    requests accidentally.
  }
  \item{cacheDir}{
    A directory for caching tiles retrieved over the web. Not used if
    tiles are coming from a local directory.
  }
  \item{timeOut}{
    Tiles in the cache directory older than this (in minutes) are
    re-retrieved.
  }
  \item{verbose}{
    If TRUE, give information on where tiles are coming from, cache
    hits, etc
  }
  \item{x}{
    A tiles object
  }
  \item{\dots}{
    Extra arguments passed to image or print
  }
  
}
\details{
These functions download, display, and manipulate map tiles stored in a
standard way either on a web server or a local folder.

Map tiles are a set of PNG images that span the world at a set of zoom
levels. Zoom level 0 has one tile that covers the whole world at a
resolution of 256x256 pixels. Zoom level 1 has four 256x256 pixel tiles
in a 2x2 pattern over the whole world. In general, zoom level n has 2^n
by 2^n tiles. Zoom levels go up to about 17 or 18 depending on the tile
server.

The function getTiles() retrieves tiles to cover a given latitude and
longitude range at a given zoom level. Note that since tiles are
generated at a fixed set of lat-long ranges the returned tiles will
overlap the requested area. There may be some way of clipping to the
requested area in a future revision.

The return value from getTiles() is an object of class "tiles", which is
basically a list of SpatialGridDataFrame objects with three bands (for
RGB colour).

The image() method for tiles objects creates a blank plot
and draws the tiles. It can be given the parameter 'add=TRUE' to overlay
them on an existing plot. Transparency is currently not supported.

The nTiles() function returns the number of tiles needed to cover the
given area at the given zoom level. Use it to check how many tiles
you'll need to get before getting them. It does not need a source of
tiles since this can be computed from the tile geometry.

The getTilePaths() function returns information about tiles in a region
at a zoom level. The tile source path is given but tiles are not
requested. A list is returned with one element per tile giving the path,
the I and J coordinates, the zoom level, and the geographic bounds for
the tile. 

The tileBbox() function returns the bounds of the tiles by simply
constructing the bounding box of all the constitutent
SpatialGridDataFrame objects.

http://wiki.openstreetmap.org/index.php/Tile_usage_policy

}
\value{
Various
}

\examples{

## how many tiles cover the world at zoom 17?
nTiles(c(-180,180),c(-89,89),17)

## realistic example:
nTiles(c(-2.842,-2.7579),c(54.0295,54.063),12)

## tile Info
tileInfo = getTilePaths(c(-2.842,-2.7579),c(54.0295,54.063),12,"http://server/")
tileInfo[[1]]

\donttest{
lancs = getTiles(c(-2.842,-2.7579),c(54.0295,54.063),12,path="http://tile.openstreetmap.org/")
}
\donttest{
image(lancs)
}
}

\author{
Barry Rowlingson
}

\keyword{hplot}

