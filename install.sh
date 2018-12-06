#!/bin/sh

# This script will perform the below actions

# Set your raspberry Pi's GPU memory split to 256mb, this
# should be sufficient for most feed layouts.
# You may decrease this if you have lower feed numbers.

gpu_mem=256

# Disable overscan which will remove black
# borders from most modern screens.

# Install docker if it is not already installed and
# add the pi user to the docker user group.

# Install docker-compose if it's not already installed.

# Create the pi_video_matrix folder and get the conf files
# from github.


# If /boot/config.txt contains "gpu_mem"
if grep -Fq gpu_mem /boot/config.txt; then
	# Replace it with new value
	sudo sed -i "/gpu_mem=/c\gpu_mem=$gpu_mem" /boot/config.txt
else
	# Append it
	sudo sh -c "echo '\ngpu_mem=$gpu_mem' >> /boot/config.txt"
fi

# If boot/config.txt contains "disable_overscan"
if grep -Fq disable_overscan /boot/config.txt; then
	# Replace it with new value
	sudo sed -i '/disable_overscan/c\disable_overscan=1' /boot/config.txt
else
	# Append it
	sudo sh -c "echo '\ndisable_overscan=1' >> /boot/config.txt"
fi

# If docker is not installed
if ! docker -v > /dev/null 2>&1; then
	# Install docker
	curl -sSL https://get.docker.com | sh  > /dev/null 2>&1
fi

# If  pi user is not in docker group
if ! groups pi | grep -q 'docker'; then
	# Add default pi user to docker group
	sudo usermod -aG docker pi
fi

# If docker-compose not installed
if ! docker-compose -v > /dev/null 2>&1; then
	if ! pip -V > /dev/null 2>&1; then
		sudo apt update
		sudo apt install -y python python-pip
	fi
	sudo pip install docker-compose
fi

# If pi_video_matrix directory doesn't exist create it
if [ ! -d ~/pi_video_matrix/conf ];then
	mkdir -p ~/pi_video_matrix/conf
fi

# Get docker-compose.yml
wget -qO ~/pi_video_matrix/docker-compose.yml https://github.com/oceaness/pi_video_matrix/raw/master/docker-compose.yml

# Get conf files
conf_files=(example.layout.conf feeds.conf pi_video_matrix.conf scheduler.conf)
for file in $conf_files; do
	wget -qO ~/pi_video_matrix/conf/$file https://github.com/oceaness/pi_video_matrix/raw/master/conf/$file
done

#sudo rpi-update > /dev/null 2>&1

# Check if pi user password has been changed
if [ -e /run/sshwarn ] ; then
	printf "\nThe password for the user 'pi' is still the default value, please change this by running passwd\n\n"
fi

echo "Please reboot your pi for the settings to take effect"
echo "After rebooting please see the pi_video_matrix.conf file in the conf directory"
