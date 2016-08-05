---
layout: post
title: "Should `quickmapr` continue?"
tags: ['R','spatial data','visualization','GIS','sp', 'raster']
categories: ['R', 'GIS']
---

Throwing a question out to the interwebs.  So about a year ago, I finished up 
development of my [`quickmapr package`](https://github.com/jhollist/quickmapr). 
It provides the ability to map and interact with `sp` and `raster` objects in 
their native coordinate reference system. Basic interaction includes zooming, 
panning, and identification and relies on `sp`and `raster` plotting functions.  
I added in a first cut at basemaps from the USGS' National Map.  It was a fun 
package to write and is (IMHO) pretty useful. That being said, while it may be 
useful, it isn't completely unique as a lot of the functionality that was 
built in can now be accomplished via the leaflet packages, most notably, 
`mapview`.  

The similarities between `mapview` and `quickmapr` are that they allow panning 
and zooming and make mapping multiple layers fairly painless.  `mapview` uses
`leaflet` and the associated javascript libraries for the mapping and 
interactivity. `quickmapr` uses `sp` and `raster` plotting methods and I rolled
my own on the interactivity by resetting extents via `locator()`.  

Some other differences are:

1. Coordinate reference systems: `mapview` converts (ultiamtely) to web mercator.
`quickmapr` makes no coversions and assumes the user will deal with projections
prior to mapping.  A simple check is done and error thrown in the projections 
do not match.  An overide argument is availble.

2. Internet connection: `quickmapr` does not need an internet connection to work,
except for the USGS basemaps.  `mapview` need and internet connection for the 
basemaps.  Not sure if it still plots without a connection.

3. Speed:  `quickmapr` works well with smallish datasets and the interactivity 
lags as those datasets increase in size.  `mapview` is noticably quicker and the 
overall experience is definetly more modern!

4. Identify: Both have the ability to identify features, but do so in different 
ways.  `mapview` uses pop-ups.  `quickmapr` again uses `locator()` but returns 
the info the R console as a list.  It is possible to select and assign the selected
features or the values from a raster.

I had started development of `quickmapr` prior to 



