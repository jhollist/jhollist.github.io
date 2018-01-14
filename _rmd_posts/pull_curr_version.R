library(xml2)
library(dplyr)
library(stringr)
url <- 'https://download2.rstudio.org'
dat <- read_xml(url)
dat_txt <- xml_text(xml_children(dat)) %>%
  tbl_df
curr_vers_date <- dat_txt %>%
  filter(str_detect(.$value,"current")) %>%
  str_sub(12,21)
deb_file<-dat_txt %>%
  filter(str_detect(.$value,curr_vers_date)) %>%
  filter(str_detect(.$value,"amd64.deb")) %>%
  filter(!str_detect(.$value,"pro")) %>%
  str_sub(1,str_locate(.$value,curr_vers_date)-1)
deb_file <- deb_file[1]
  


