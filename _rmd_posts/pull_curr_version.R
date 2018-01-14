library(xml2)
library(dplyr)
library(stringr)
url <- 'https://download2.rstudio.org'
dat <- read_xml(url)
dat_l <- as(xml_children(dat), "list")
xml_text(dat_l[[6]])
