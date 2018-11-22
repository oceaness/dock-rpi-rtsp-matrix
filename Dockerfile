FROM resin/rpi-raspbian

# Required for omxplayer
ENV LD_LIBRARY_PATH=/opt/vc/lib

RUN apt-get update && \
	apt-get install \
	omxplayer \
	fbi && \
	apt-get clean

COPY /app /usr/bin

RUN ln -s /opt/vc/bin/vcgencmd /usr/bin/vcgencmd && \
	chmod +x \
	/usr/bin/displaycameras \
	/usr/bin/omxplayer_dbuscontrol \
	/usr/bin/rotatedisplays \
	/usr/bin/scheduler

#CMD /usr/bin/scheduler