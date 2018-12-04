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
	/usr/bin/pi_video_matrix \
	/usr/bin/omxplayer_dbuscontrol \
	/usr/bin/rotatedisplays \
	/usr/bin/gen_matrix \
	/usr/bin/scheduler

STOPSIGNAL SIGTERM
ENTRYPOINT [ "tini", "--" ]
CMD [ "scheduler" ]