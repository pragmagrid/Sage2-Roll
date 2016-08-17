# Sage2-Roll
##Rocks Roll for UIC/EVL's Sage2 software
Provides the needed dependencies to run the Sage2 server as well as the server software itself.  

Description from a paper on Sage2 (taken from the [Sage2](http://sage2.sagecommons.org/project/publications/) website):
>Current web-based collaboration systems, such as
>Google Hangouts, WebEx, and Skype, primarily enable single
>users to work with remote collaborators through video
>conferencing and desktop mirroring. The original SAGE
>software, developed in 2004 and adopted at over one hundred
>international sites, was designed to enable groups to work in
>front of large shared displays in order to solve problems that
>required juxtaposing large volumes of information in ultra highresolution.
>We have developed SAGE2, as a complete redesign
>and implementation of SAGE, using cloud-based and web
>browser technologies in order to enhance data intensive colocated
>and remote collaboration. 

##Building and Installing

**Building**
	
In the main folder of the roll:

Build the roll using: 
		
	# make roll 2>&1 | tee make.log 
  	
If successful, this will build a .iso file called ''Sage2-*.disk1.iso''. 

**Installation**
	
To install on a node, execute: 
	
	# rocks add roll *.iso
	# rocks enable roll Sage2_Roll
	# (cd /export/rocks/install; rocks create distro)
	# rocks run roll Sage2_Roll | bash

**What is installed:**
	
* /opt/Sage2: Sage2 server 
* ~/Documents/SAGE2_MEDIA: Images, Videos, Pdfs...etc that are uploaded to the sage2 wall by users.
* /opt/ffmpeg: depencency needed by sage2 to handle video files
* /opt/gcc: version 4.8.2 of the gcc compiler, needed by NodeJS as the one included in Centos 6 is too old
* /opt/x264, /opt/lame, /opt/libtheora, /opt/libvorbis, /opt/libwebp: Dependencies for ffmpeg
* /opt/tiff: Dependency for Sage2
* /opt/ImageMagick: Dependency of Sage2
* /opt/Image-ExifTool: Dependency of Sage2 for reading exif data of images
* /opt/node: version 4.4.7 of NodeJS, the javascript application framework Sage2 is written in.

##Quick User's Guide
	
More in depth instructions (not specific to Rocks) can be found at the [Sage2 website](http://sage2.sagecommons.org/instructions/).

**Post Installation**
	
* Inside the /opt/Sage2 folder, go to the keys folder and edit the GO-linux script adding the ip address you wish to connect to the 	     Sage2 server at inside the servers variable. 
*       run the GO-linux script with:
		# ./GO-linux  
* Now go back to the main Sage2 directory and run the command:
* 		# npm run in

* This will install all the needed NodeJS dependencies for Sage2

**Starting the Sage2 Server**

* In the main Sage2 folder, run:
*       # node server.js
   
	 This will run the sage2 server process, however it will use the default config file that assumes your display wall contains only a single 1080p monitor, which must be changed if you your display wall's configuration differs from this.
* From your front end launch google chrome on each display node  by launching a google chrome window for each monitor in your Sage2 wall: 
* 			# runuser -l WALL_USERNAME -c 'ssh -t NODE_HOST_NAME "export DISPLAY=CURRENT_DISPLAY && google-chrome --user-data-dir=~/.config/google-chrome/TILE_CONFIG_PROFILE --kiosk --app=https://SAGE2_SERVER_IP:SAGE2_PORT/display.html?clientID=TILE_ID "'&

* WALL_USERNAME is the username you use to login to each compute node (in mine for instance its sageuser) while NODE_HOST_NAME is the hostname of the compute node (such as compute-0-0) you are logging into. 
* CURRENT_DISPLAY is the output of $DISPLAY (assuming each display is it's own x window, which in my experience had alot less issues than with xinerama enabled) which is the monitor that you want to launch one part of your sage2 server on. This also ties in with the TILE_ID as that represents which part of the wall is displayed. For instance if you had a 4 monitor display wall client id 0 might be the top right part of the wall while id 3 is the lower right portion, it depends on your Sage2 config file.
* TILE_CONFIG_PROFILE should be different for each monitor you are launching the sage2 server on as otherwise chrome will complain about having to share the same profile for multiple instances of chrome of the same username. 


* The server can be exited by typing exit on the Sage2 sever console.

