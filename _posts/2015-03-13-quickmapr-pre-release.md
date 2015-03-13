---
layout: post
title: "quickmapr: An R package for mapping and interacting with spatial data"
tags: ['R','spatial data','visualization','pan','zoom','sp', 'raster']
categories: ['R']
---

I do a lot of GIS.  That used to mean firing up any one of the esri products, but over the course of the last couple of years I have done that less and less and instead fired up R.  

When I first started using R for my spatial analysis work I often was left struggling with viewing the results of my analysis and could only do so with a clunky workflow of pushing my `sp` or `raster` objects out to shapefiles or tiffs and then pulling those into Arcmap.  In short, spatial data visualization was severely lacking in R.

Fast forward to now, and that has all really started to change.  Most of the work in this space has been on incorporating the slew of javascript tools (e.g. D3, leaflet, Crosslet) for visualizing spatial data.  This has resulted in some really cool packages like:

- [cartographer](https://github.com/ropensci/cartographer)
- [leaflet](http://rstudio.github.io/leaflet/)
- [ggmap](http://journal.r-project.org/archive/2013-1/kahle-wickham.pdf)
- [rMaps](http://rmaps.github.io/)

These all result in great looking maps with nice interactivity; however, they all have two things in common.  One, it is expected that your data are unprojected (i.e. Longitude and Latitude) and two that the data are simple text or in JSON (either GeoJSON or TopoJSON).  This works for many use cases, but not for mine.  

I usually start with small(ish) spatial data that are stored in GIS formats (e.g. shapefiles, esri rasters, file geodabase, etc.) and are projected.  I use `rgdal` or `raster` to pull those into R and then do whatever it is I am doing to those and get `sp` and `raster` objects as output.  At this point all I want to be able to do is quickly visualize the resultant data (usually less than 3 or 4 layers at a time), interact with that data by zooming, panning, and identifying values in the data interactively.  I want to be able to this without having to convert to JSON or without having to un-project the data.  The result of this desire is [quickmapr](https://github.com/jhollist/quickmapr).  

With `quickmapr` you set up a `qmap` object by passing as many `sp` and `raster` objects as you'd like.  There are some very basic controls on draw order and color.  There are several zoom functions, a pan function, an identify function (which also returns the selected `sp` object or `raster` value), and a (currently very clunky) labeling function.  This package is still a work in progress and I am hoping to keep working on `quickmapr` and tweaking how it works. I would love feedback so if you have thoughts, comments, complaints, etc don't hesitate to leave some comments here, or better yet [post issues on github](https://github.com/jhollist/quickmapr/issues), or fork the repo and make changes yourself.  I will try and get up some contributing guidelines in the not too distant future.  