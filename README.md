# Project Description
pi_video_matrix is a docker container run on Raspberry Pi hardware to locally display a matrix of RTSP streams, such as those from Ubiquiti's Unifi Video CCTV camera system. It uses omxplayer to perform hardware accelerated playback of each configured feed in a grid of "windows". It uses omxplayer's integration with DBUS to perform monitored startup, watchdog, and repair functions on feeds in order to maximize predictable, reliable performance. It will attempt to automatically generate an appropriate config file based on minimal input. It is capable of displaying more feeds than there are visible windows in your display grid by rendering some feeds off screen and rotating feeds through window positions.

# Prerequisites
* Raspberry Pi hardware
* Raspbian OS (other OS's may work but are not supported)

# Download/Installation
The easiest way to download and install the necessary files is to run  
`bash <(wget -qO- https://github.com/oceaness/pi_video_matrix/raw/master/install.sh)`  
this will perform the following actions:

1. Set your Raspberry Pi's GPU memory split to 256mb
2. Disable display overscan as it is not required on most modern monitors
3. Install docker if it is not already installed
4. Add Raspbians default pi user to the docker user group
5. Install python, pip and docker-compose if they are not already installed
6. Create pi_video_matrix and conf directory in home
7. Download docker-compose.yml and conf files

After these actions are complete you will need to reboot your Pi for the config changes to take effect.

# Configuration
Before you can run the container you must edit feeds.conf.

Instructions for how to do this and the rest of the configuration options are are contained within the config files and in the README.md within the [conf directory](conf).

# Container actions
Once you have made the required configuration changes, you can start, stop and remove the container using the standard docker-compose functions. Start it using `docker-compose up -d`. After a few seconds the Raspberry Pi's monitor should go blank and video feeds should start appearing one by one. Stop the container by running `docker-compose down`.

# Credit
Much of the code contained herein borrows heavily from [Anonymousdog/displaycameras](https://github.com/Anonymousdog/displaycameras).