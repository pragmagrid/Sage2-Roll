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

	Build the roll using: ::
		# make roll 2>&1 | tee make.log 
  	If successful, this will build a .iso file called ''Sage2-*.disk1.iso''. 

**Installation**
	
	To install on a node, execute: ::
	
	# rocks add roll *.iso
	# rocks enable roll Sage2_Roll
	# (cd /export/rocks/install; rocks create distro)
        # rocks run roll Sage2_Roll | bash

**What is installed**
	* /opt/Sage2: Sage2 server 
	* ~/Documents/SAGE2_MEDIA: Images, Videos, Pdfs...etc that are uploaded to the sage2 wall by users.
	* /opt/ffmpeg: depencency needed by sage2 to handle video files
	* /opt/gcc: version 4.8.2 of the gcc compiler, needed by NodeJS as the one included in Centos 6 is too old
	* /opt/x264, /opt/lame, /opt/libtheora, /opt/libvorbis, /opt/libwebp: Dependencies of for ffmpeg
	* /opt/tiff: Dependency for Sage2
	* /opt/ImageMagick: Dependency of Sage2
	* /opt/Image-ExifTool: Dependency of Sage2 for reading exif data of images
	* /opt/node: version 4.4.7 of NodeJS, the javascript application framework Sage2 is written in.

##Quick User's Guide
	
