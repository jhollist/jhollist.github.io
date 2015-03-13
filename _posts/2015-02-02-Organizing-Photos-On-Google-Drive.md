---
layout: post
title: "Automatically Organizing Photographs on Google Drive: Why isn't this already a thing?"
tags: ['Google Drive','grive','exiftool','categories','crontab','bash script']
categories: ['Hacking']
---

Over the last year or so, my wife and I have been moving most our files onto Google Drive.  This has worked great as we have access across all of our devices.  The last vestiges of local storage have been our photos.  With the recent purchase of a Chromebook (which I've been impressed with but that is a different post...) and the 1TB of Google Drive storage that came with it, I decided to take the plunge and get our photos up their too.  

Now, I thought that getting the photos moved and organized would be a snap because there certainly had to be a solution for keeping photos on Drive and organized.  There were many options but none of them perfect.  Many of them relied on Google+ Photos (I am not a fan of Google+), struggled with organizing large numbers of photos (nearly 20k), or were not able to be automated. It quickly became clear that I had to more less roll my own.

The solution I settled on in the end was to use a simple bash script set up as a cron job on an Ubuntu box that called [grive](https://github.com/Grive/grive) and [exiftool](http://www.sno.phy.queensu.ca/~phil/exiftool/).  

**Update 3/13/2015:**  I was going to have more in this post, but didn't get around to it.  In the meantime, `grive` started giving me problems and wasn't syning correctly.  I think I have a solution that uses [google-drive-oacmlfuse](https://github.com/astrada/google-drive-ocamlfuse) to just mount google drive directly on the linux box.  I need to update my bash scripts and once I get that done, I'll post those scripts here.
