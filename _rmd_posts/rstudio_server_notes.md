# Notes for setting up RStudio Server in a chroot

1. set up chroot

```
sudo sh ~/Downloads/crouton -t cli-extra -n rstudio
```
2. install R

```
sudo echo "deb http://cran.rstudio.com/bin/linux/ubuntu xenial/" | sudo tee -a /etc/apt/sources.list
gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
gpg -a --export E084DAB9 | sudo apt-key add -
sudo apt-get update
sudo apt-get install r-base r-base-dev
```
3. install RStudio Server

```
sudo apt-get install gdebi-core
wget https://download2.rstudio.org/rstudio-server-1.1.383-amd64.deb
sudo gdebi rstudio-server-1.1.383-amd64.deb
rm rstudio-server-1.1.383-amd64.deb
```

4. open up firewall

```
sudo apt-get install nano
sudo nano /etc/rc.local
```
Then add `/sbin/iptables -I INPUT -p tcp --dport 8787 -j` to the end of the file

5. get RStudio server running and access it

```
sudo rstudio-server start
```
Then in your browser you can access your RStudio Server with `localhost:8787`

5. draw the rest of f***ing owl

```
sudo locale-gen "en_US.UTF-8"
sudo dpkg-reconfigure locales
sudo apt-get install software-properties-common
sudo apt-get install libxslt-dev libcurl4-openssl-dev libssl-dev
sudo apt-get update
sudo apt-get install libgdal-dev libproj-dev
sudo apt-get install libudunits2-dev
sudo apt-get install texlive texlive-latex-extra texlive-pictures
sudo apt-get install git
sudo apt-get install libssh2-1-dev
```
  
6. day to day use

There is a way to have your chroot automatically boot with Chrome OS.  I couldnt get it working.  So simplest solution is to:

- start up your chromebook
- open crosh - ctrl-alt-t
- type `shell`
- type `sudo startcli`
- type `sudo rstudio-server start`

You will need to leave this tab open, otherwise it shuts down the chroot and your RStudio Server.

I have to think there is a way to have to have the chroot start with Chrome OS and have the server automatically start with the chroot.  Leave that for another day!

The first time I get RStudio open I want to install all my usual suspects.  With this set up I had no issues installing the following

```
install.packages("devtools")
install.packages("tidyverse")
install.packages("sf")
install.packages("raster")
install.packages("mapview")
install.packages("sp")
install.packages("rgdal")
install.packages("rgeos")
install.packages("roxygen2")
```

Then my own just to have them

```
devtools::install_github("jhollist/miscPackage")
install.packages("lakemorpho")
install.packages("quickmapr")
install.packages("elevatr")
```

Oh, and don't forget to configure git!

```
git config --global user.name "Your Name"
git config --global user.email "your.email@email.com"
```