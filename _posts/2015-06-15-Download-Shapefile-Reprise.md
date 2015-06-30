---
layout: post
title: "Download Shapefiles - Take 2"
tags: ['Shapefiles','httr']
categories: ['R']
---



So back in 2013 I [posted a little function](https://landeco2point0.wordpress.com/2013/09/30/an-r-function-to-download-shapefiles/) I wrote for grabbing all the relevant files that make up a shapefile from a URL.  Turns out it doesn't play so well with Windows 7 or Windows 8 (HT: John Lewis).  Below is a reprised version that at least works on Ubuntu 14.04 and Windows 7.  Haven't tested it beyond that and supressing the warnings to get `httr::GET` to not complain too much about FTP seems a bit unclean.  Well, you get what you pay for. 

For all this to run you'll need `RCurl`, `httr`, `sp`, and `rgdal`.


```r
#' function to download all available shapefile files from a URL
#' @import RCurl
#' @export
#' @examples
#' \dontrun{
#' download_shp("ftp://ftp.granit.sr.unh.edu/pub/GRANIT_Data/Vector_Data/Administrative_and_Political_Boundaries/d-nhsenatedists/2012","NHSenateDists2012")
#' download_shp("http://jwhollister.com/iale_open_science/files","LocPt")
#' }
download_shp<-function (shape_url, layer, outfolder = ".") 
{
  if (length(grep("/$", shape_url)) == 0) {
    shape_url <- paste(shape_url, "/", sep = "")
  }
  
  shapefile_ext <- c(".shp", ".shx", ".dbf", ".prj", ".sbn", 
                     ".sbx", ".shp.xml", ".fbn", ".fbx", ".ain", ".aih", ".ixs", 
                     ".mxs", ".atx", ".cpg")

  xlogic <- NULL
  if(substr(shape_url,1,3)=="ftp"){
    xurl <- RCurl::getURL(shape_url)
    for (i in paste(layer, shapefile_ext, sep = "")) {
      xlogic <- c(xlogic, grepl(i, xurl))
    }
  } else if(substr(shape_url,1,4)=="http"){
    for (i in paste(shape_url,layer, shapefile_ext, sep = "")) {
      xlogic <- c(xlogic,httr::HEAD(i)$status==200)
    }  
  }
  
 
  shapefiles <- paste(shape_url, layer, shapefile_ext, 
                      sep = "")[xlogic]
  outfiles <- paste(outfolder, "/", layer, shapefile_ext, 
                    sep = "")[xlogic]
  
  if (sum(xlogic) > 0) {
    for (i in 1:length(shapefiles)) {
      x <- suppressWarnings(httr::GET(shapefiles[i], 
                                      httr::write_disk(outfiles[i],
                                                       overwrite = TRUE)))
      
      dwnld_file <- strsplit(shapefiles[i], "/")[[1]]
      dwnld_file <- dwnld_file[length(dwnld_file)]
      
      print(paste0("Downloaded ", dwnld_file, " to ", 
                   outfiles[i], "."))
    }
  }
  else {
    stop("An Error has occured with the input URL or 
              name of shapefile")
  }
}
```

And to see that it works again:


```r
#Download the NH State Boundaries
download_shp("ftp://ftp.granit.sr.unh.edu/pub/GRANIT_Data/Vector_Data/Administrative_and_Political_Boundaries/d-nhsenatedists/2012",
                   "NHSenateDists2012")
```

```
## [1] "Downloaded NHSenateDists2012.shp to ./NHSenateDists2012.shp."
## [1] "Downloaded NHSenateDists2012.shx to ./NHSenateDists2012.shx."
## [1] "Downloaded NHSenateDists2012.dbf to ./NHSenateDists2012.dbf."
## [1] "Downloaded NHSenateDists2012.prj to ./NHSenateDists2012.prj."
## [1] "Downloaded NHSenateDists2012.sbn to ./NHSenateDists2012.sbn."
## [1] "Downloaded NHSenateDists2012.sbx to ./NHSenateDists2012.sbx."
```

```r
#Read shapefiles in SpatialPolygonsDataFrame
NHBnd<-readOGR(".","NHSenateDists2012")
```

```
## OGR data source with driver: ESRI Shapefile 
## Source: ".", layer: "NHSenateDists2012"
## with 24 features
## It has 4 fields
```

```r
#Plot it
plot(NHBnd)
```

![plot of chunk run_it](figure/run_it-1.png) 
