FROM resin/rpi-raspbian

# Required for omxplayer
ENV LD_LIBRARY_PATH=/opt/vc/lib

RUN apt-get update && \
	apt-get install \
	omxplayer \
	fbi && \
	apt-get clean

WORKDIR /app
COPY /app .

RUN ln -s /opt/vc/bin/vcgencmd /usr/bin/vcgencmd && \
	chmod +x scheduler.sh install.sh && \
	./install.sh

#CMD ./scheduler.sh