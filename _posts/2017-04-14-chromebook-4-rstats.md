---
layout: post
title: "Setting up an Asus Flip C302CA Chromebook for R Development"
tags: ['chromeOS','Chromebook','crouton','xiwi','RStudio']
categories: ['R','r']
---



Don't think of this as a real blog post.  It is mostly a loose collection of notes that I took while getting my new [Asus Flip C302CA](https://www.asus.com/us/Notebooks/ASUS-Chromebook-Flip-C302CA/) set up with R and RStudio.  I've had this up and running for just a few days now (and in fact wrote this post using RStudio on it) and I love it.  I highly recommend.  

The steps below are not really tested.  So if you run into problems or I have missed something, let me know.  

# Steps
1. Enter Developer Mode
  - Esc - Refresh - Power
  - Follow directions
  - Takes a while (~30 minutes)
2. Download crouton
3. Add crouton integration extension
4. Create chroot
  - Open crosh - `ctrl-alt-T`
  - Start bash - `shell`
  - Intall xfce xiwi extension touch
    - `sudo sh ~/Downloads/crouton -e -t xfce,touch,xiwi,extension`
  - It'll ask for a new username and password
  - Since we are encrypting the chroot (with `-e`) it will also ask for a passphrase. I'm certainly not a security expert, but don't use the same one as your google or new chroot password...
  - This takes a while (~15 minutes)
5. You should now have a working ubuntu install with the xfce desktop available.  Fire that up.
  - If you don't have shell still open, get to that (`ctrl-alt-T` and `shell`)
  - type `sudo startxfce4`
  - Ta-da!  Linux!
6. Now we can start installing all the tools that we need from our xfce window.
  - get to a terminal
  - Install Git
    - `sudo apt-get install git`
  - Install R
    - For more: <https://cran.r-project.org/bin/linux/ubuntu/README.html> and nice streamlined instructions  <https://www.datascienceriot.com/how-to-install-r-in-linux-ubuntu-16-04-xenial-xerus/kris/>

```
sudo echo "deb http://cran.rstudio.com/bin/linux/ubuntu xenial/" | sudo tee -a /etc/apt/sources.list
gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
gpg -a --export E084DAB9 | sudo apt-key add -
sudo apt-get update
sudo apt-get install r-base r-base-dev
```
  - Install RStudio
    - I like to live on the edge so I usually have a fairly recent daily running.  Here's how you get that.
    - You will also need to add some older versions of libgstreamer.  Good details on this from [Mike Williamson](https://mikewilliamson.wordpress.com/2016/11/14/installing-r-studio-on-ubuntu-16-10/).
    - I also delete the `.deb` since this is on a chromebook.  Space will likely be at a bit of a premium.
    
```
# Download the installs
wget https://s3.amazonaws.com/rstudio-dailybuilds/rstudio-1.1.244-amd64.deb
wget http://ftp.ca.debian.org/debian/pool/main/g/gstreamer0.10/libgstreamer0.10-0_0.10.36-1.5_amd64.deb
wget http://ftp.ca.debian.org/debian/pool/main/g/gst-plugins-base0.10/libgstreamer-plugins-base0.10-0_0.10.36-2_amd64.deb
 
# Now install deps with dpkg and mark to not update
sudo dpkg -i libgstreamer0.10-0_0.10.36-1.5_amd64.deb
sudo dpkg -i libgstreamer-plugins-base0.10-0_0.10.36-2_amd64.deb
sudo apt-mark hold libgstreamer-plugins-base0.10-0
sudo apt-mark hold libgstreamer0.10

# Lastly install rstudio
sudo gdebi rstudio-1.1.244-amd64.deb
rm rstudio-1.1.201-amd64.deb
```
  - The following are the notes I had for which libraries I added.  My notes were a bit of a mess so this might not be all or may be too many.

Some of the basics (i.e. for `devtools`)

```
sudo apt-get install libxslt-dev libcurl4-openssl-dev libssl-dev
```

The spatial stuff.  This also adds the ubuntugis repo so that you can get the latest and greatest.  The latest is at <https://launchpad.net/~ubuntugis/+archive/ubuntu/ubuntugis-unstable>

But, `add-apt-repository` was not installed.  To get that I used `sudo apt-get install software-properties-common`.  Now to add the GIS stuff.

```
sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable
sudo apt-get update
sudo apt-get install libgdal-dev libproj-dev
```

In addition to gdal, geos, and proj, `libudunits2-dev` is needed and can be installed with apt-get: `sudo apt-get install libudunits2-dev`.

Also, if you do any work with `rmarkdown`, `knitr`, and the like you will probably want a working install of latex.  I used the following:

```
sudo apt-get install texlive texlive-latex-extras texlive-pictures
```

7. Working with RStudio on your chromebook

Not a whole lot of details here.  Just some basic notes I had for myslef.  First, I am using a 64GB microSD card to give myself some room and I keep all of my projects stored on this card (as well as on GitHub).  I just set up a symbolic link to this from my home folder.  Something like the following should do the trick.

```
cd 
ln -s /var/host/media/removable/SD\ Card/ projects
```
With this you can get to the card easier (e.g. `cd ~/projects`).  Only issue I have had with this is that trying to browse local HTML files from R blows up as the linux path to the SD Card doesn't play nice on the Chrome OS side.  Still need to figure this one out.

I am still playing around with the best way to fire up rstudio.  There are two ways I am doing this.  Either firing up a separate desktop and using RStudio from there or starting RStudio in its own window.  I think I prefer the later, but time will tell.  You already know how to fire up the desktop.  You can use `rstudio` from a terminal or find it in your applications menu. For the RStudio in its own window, I added this:

```
alias rstudio="sudo startxiwi rstudio -F"
```

to my `~/.bashrc` in the chromebook (not the chroot!) shell.  Then I can fire up rstudio with `ctrl-alt-T`, then `shell`, then  `rstudio`.

Given the hi-res of the screen, you'll need to either get super vision or mess with the display settings in the Xfce desktop or adjust the X11 setting that the Chrome crouton integration is using.  I used a lot of the suggestions in the [crouton on Pixel section of the crouton Wiki](https://github.com/dnschneid/crouton/wiki/Chromebook-Pixel).  In particular, Option 1 helped with firing up RStudio direction.  I also bumped the zoom in my RStudio Global options.

Lastly, the locale is not set in your linux install so to take care of that, I followed [these directions from Ask Ubuntu](https://askubuntu.com/questions/162391/how-do-i-fix-my-locale-issue).  In particular:

```
sudo locale-gen "en_US.UTF-8"
sudo dpkg-reconfigure locales #you'll need to cycle through with arrows, tabs, and enters
```
I **think** that should do the trick on any locale issues, but dealing with this made me realize how little I actually now about locales and text encoding...

Fnally and hopefully you should now be ready to roll with R and R development on your fancy new chromebook!  See below for some additional links.

# Some related links
- [Web Dev on chromebook - 1](https://medium.com/@martinmalinda/ultimate-guide-for-web-development-on-chromebook-part-1-crouton-2ec2e6bb2a2d)
- [Web Dev on Chromebook - 2](https://medium.com/@martinmalinda/ultimate-guide-for-web-development-on-chromebook-part-2-chromeos-tricks-and-workflows-4dfcc308d391)
- [Yet another crouton how to](https://www.codedonut.com/chromebook/install-crouton-chromebook/)
