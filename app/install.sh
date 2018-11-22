# What is the path to the installer?
DIR=`dirname "$(readlink -f "$0")"`

# Put the files in place and set ownership and permissions.

if [ -r $DIR/displaycameras ]; then
	echo "Copying the main script and setting permissions."
	cp -f $DIR/displaycameras /usr/bin/ && chown root:root /usr/bin/displaycameras && chmod 0755 /usr/bin/displaycameras
else
	echo "The displaycameras file is missing or unreadable. This is a critical file."
	echo "Verify package contents."
	exit 1
fi

# Config files, cron job, gpu memory split, and disable overscan support only if not upgrading

#if [ "$1" != "upgrade" ]; then
#	if [ -r $DIR/displaycameras.conf ]; then
#		if [ -r /etc/displaycameras/displaycameras.conf ]; then
#			[ -d /etc/displaycameras/bak ] || mkdir /etc/displaycameras/bak
#			for i in `find /etc/displaycameras/ -maxdepth 1 -type f`; do
#				mv -f $i /etc/displaycameras/bak/
#			done
#			echo "Your config files were backed up to /etc/displaycameras/bak"
#		fi
#		echo "Copying the global and layout configuration files."
#		[ -d /etc/displaycameras ] || mkdir /etc/displaycameras
#		cp -f $DIR/layout.conf.default /etc/displaycameras/ && chown root:root /etc/displaycameras/layout.conf.default && chmod 0644 /etc/displaycameras/layout.conf.default
#		cp -f $DIR/displaycameras.conf /etc/displaycameras/ && chown root:root /etc/displaycameras/displaycameras.conf && chmod 0644 /etc/displaycameras/displaycameras.conf
#	else
#		echo "The displaycameras.conf file is missing or unreadable. This is a critical file."
#		echo "Verify package contents."
#		exit 3
#	fi
#fi

if [ -r $DIR/omxplayer_dbuscontrol ]; then
	echo "Copying the omxplayer control script."
	cp -f $DIR/omxplayer_dbuscontrol /usr/bin/ && chown root:root /usr/bin/omxplayer_dbuscontrol && chmod 0755 /usr/bin/omxplayer_dbuscontrol
else
	echo "The omxplayer_dbuscontrl file is missing or unreadable. This is a critical file."
	echo "Verify package contents."
	exit 5
fi

if [ -r $DIR/rotatedisplays ]; then
	echo "Copying the display rotating script and setting permissions."
	cp -f $DIR/rotatedisplays /usr/bin/ && chown root:root /usr/bin/rotatedisplays && chmod 0755 /usr/bin/rotatedisplays
else
	echo "The rotatedisplays file is missing or unreadable. This file is required to support display rotation."
	echo "Verify package contents."
fi

if [ -r $DIR/black.png ]; then
	echo "Copying the black background file and setting ownership."
	cp -f $DIR/black.png /usr/bin/ && chown root:root /usr/bin/black.png
else
	echo "The black.png file is missing or unreadable. Screen blanking will not work"
	echo "with out it.  Verify package contents."
fi

echo "Installation Successful!"
exit 0
