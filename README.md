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
* /opt/gcc: version 4.8.2 of the gcc compiler, needed by NodeJS as the version of gcc included in Centos 6 is too old
* /opt/x264, /opt/lame, /opt/libtheora, /opt/libvorbis, /opt/libwebp: Dependencies for ffmpeg
* /opt/tiff: Dependency for Sage2
* /opt/ImageMagick: Dependency of Sage2
* /opt/Image-ExifTool: Dependency of Sage2 for reading exif data of images
* /opt/node: version 4.4.7 of NodeJS, the javascript application framework Sage2 is written in.

##Basic User's Guide
	
More in depth instructions (not specific to Rocks) can be found at the [Sage2 website](http://sage2.sagecommons.org/instructions/).

**Post Installation**
	
* Inside the /opt/Sage2 folder, go to the keys folder and edit servers variable of the GO-linux script with the ip address of the node that will be running the Sage2 server. 
*       Then run the GO-linux script with:
		# ./GO-linux  
*	This will generate the self signed certificates needed for https connections (note, it is always better to use properly signed certificates but this will funciton if you are just trying to get Sage2 to work).
* Now go back to the main Sage2 directory and run the command:
* 		# npm run in

* This will install all the needed NodeJS dependencies for Sage2

**Starting the Sage2 Server**

* In the main Sage2 folder, run:
*       # node server.js
   
	 This will run the sage2 server process, however it will use the default config file that assumes your display wall contains only a single 1080p monitor, which must be changed if you your display wall's configuration differs from this.
* From your front end launch google chrome on each display node  by launching a google chrome window (the preferred browser by Sage2's developers) for each monitor in your Sage2 wall: 
* 			# runuser -l WALL_USERNAME -c 'ssh -t NODE_HOST_NAME "export DISPLAY=CURRENT_DISPLAY && google-chrome --user-data-dir=~/.config/google-chrome/TILE_CONFIG_PROFILE --kiosk --app=https://SAGE2_SERVER_IP:SAGE2_PORT/display.html?clientID=TILE_ID "'&

* You may see a warning about in chrome that the following website is unsecure due to a self-signed https certificate, just click advance and procced to the ip of your sage2 server. You might also want to consider using a properly signed certificate later as well.
* WALL_USERNAME is the username you use to login to each compute node (in mine for instance its sageuser) while NODE_HOST_NAME is the hostname of the compute node (such as compute-0-0) you are logging into. 
* CURRENT_DISPLAY is the output of $DISPLAY (assuming each display is it's own x window, which in my experience had alot less issues than with xinerama enabled) which is the monitor that you want to launch one part of your sage2 server on. This also ties in with the TILE_ID as that represents which part of the wall is displayed. For instance if you had a 4 monitor display wall client id 0 might be the top right part of the wall while id 3 is the lower right portion, it depends on your Sage2 config file.
* TILE_CONFIG_PROFILE should be different for each monitor you are launching the sage2 server on as otherwise chrome will complain about having to share the same profile for multiple instances of chrome of the same username. 


* The server can be exited by typing exit on the Sage2 sever console.

**Interacting with the Sage2 Wall**

* In the web browser of your choice (again google-chrome is recommended) go to:

* 		# https://SAGE2_SERVER_IP:SAGE2_PORT
* If you get the same security warning in your browser as described above, follow the same instructins proceed to the ip address of your sage2 server. 
* Once you are at the main page of the sage2 server, it presents you with a simplified version of what is currently being displayed on the actual display wall with buttons going from left to right:
	* SAGE2 Pointer takes control of your keyboard and mouse (has to be allowed in your browser settings) so your cursor movments are on the wall itself.
	* Screen Sharing (currently for google chrome only with an extension) allows you to broadcast the contents of a window or the whole screen to the display wall.
	* App launcher will open a window that shows all the possible apps that come with Sage2 (there is an api that allows you to develop your own as well) and allows limited interaction on this page while the full interaction is on the wall itself.
	* Media browser shows a file explorer like window that allows you to launch pdfs, images, video files and more to be displayed on your display wall. In addition, it allows you to drag and drop new files from your desktop to be uploaded to the wall. 
	* Arrangment allows you to take whatever is on the display wall currently and either clear it, make it tiled, or save the arrangement for later if it gets changed.
	* The settings button allows you to customize the name that shows up when your cursor goes onto the display wall as well as the color. It also lets you choose the streaming quality if you want to share your screen.
	* Information gives some details on the wall's configuration, the version of sage2, a link to the documentation, and some admin controls.
	* Quick Note and Doodle allows you to place sticky notes on the wall and draw items respectively.
* After activating the SAGE2 Pointer, you can right click to show the radial menu which allows you to do many of the same tasks as the main server webpage but in a format that is better suited to the wall. 
* Once you launch an app on the sage wall, right clicking it while using the sage2 pointer will bring up any additional functionality that is available. For instance once a video is playing, right clicking the app will let you pause/play, scrub through, and stop the video app.


