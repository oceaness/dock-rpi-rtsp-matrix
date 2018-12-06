# Project Description
pi_video_matrix is a docker container run on Raspberry Pi hardware to locally display a matrix of RTSP streams, such as those from Ubiquiti's Unifi Video CCTV camera system. It uses omxplayer to perform hardware accelerated playback of each configured feed in a grid of "windows". It uses omxplayer's integration with DBUS to perform monitored startup, watchdog, and repair functions on feeds in order to maximize predictable, reliable performance. It will attempt to automatically generate an appropriate config file based on minimal input. It is capable of displaying more feeds than there are visible windows in your display grid by rendering some feeds off screen and rotating feeds through window positions.

# Pre-requisites
* Raspberry Pi hardware
* Raspbian OS (other OS's may work but are not supported)

# Download/Installation
The easiest way to download and install the necessary files is to run  
`bash <(wget -qO- https://github.com/oceaness/pi_video_matrix/raw/master/install.sh)`  
this will perform the following actions:

1. Set your Raspberry Pi's GPU memory split to 256mb
2. Disable display overscan as it is not required on most modern monitors
3. Install docker if it is not already installed
4. Add Raspbians default Pi user to the docker user group
5. Install docker-compose if it is not already installed
6. Create pi_video_matrix and conf directory in home
7. Download docker-compose.yml and conf files

After these actions are complete you will need to reboot your Pi for the config changes to take effect.

# Configuration
Before you can run the container you will need to make some minimal changes to at least the pi_video_matrix.conf file, and provide some video feed URLs in the feeds.conf file.

Instructions for how to do this are contained within those files and in the README.md within the conf directory.
[a relative link](conf)