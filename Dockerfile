FROM resin/rpi-raspbian

# Required for omxplayer
ENV LD_LIBRARY_PATH=/opt/vc/lib

RUN ulimit -n 1024 && \
	apt-get update && \
	apt-get install \
	omxplayer \
	fbi && \
	apt-get clean

COPY /app /usr/bin
COPY /opt /opt

STOPSIGNAL SIGTERM
ENTRYPOINT [ "tini", "--" ]
CMD [ "scheduler" ]