#!/bin/bash

# This script will perform the below actions

# Set your raspberry Pi's GPU memory split to 256mb, this
# should be sufficient for most feed layouts.
# You may decrease this below if you have lower feed numbers.

gpu_mem=256

# Disable overscan which will remove black
# borders from most modern screens.

# Install docker if it is not already installed and
# add the pi user to the docker user group.

# Install python and pip and then docker-compose if they are not already installed.

# Create the pi_video_matrix folder and get the conf files
# from github.


# If /boot/config.txt contains "gpu_mem"
if grep -Fq gpu_mem /boot/config.txt; then
	echo "Editing gpu_mem config line in /boot/config.txt"
	sudo sed -i "/gpu_mem=/c\gpu_mem=$gpu_mem" /boot/config.txt
else
	echo "Adding gpu_mem config line to /boot/config.txt"
	sudo sh -c "echo '\ngpu_mem=$gpu_mem' >> /boot/config.txt"
fi

# If boot/config.txt contains "disable_overscan"
if grep -Fq disable_overscan /boot/config.txt; then
	echo "Editing disable_overscan config line in /boot/config.txt"
	sudo sed -i '/disable_overscan/c\disable_overscan=1' /boot/config.txt
else
	echo "Adding disable_overscan config line to /boot/config.txt"
	sudo sh -c "echo '\ndisable_overscan=1' >> /boot/config.txt"
fi

# If docker is not installed
if docker -v > /dev/null 2>&1; then
	echo "Docker already installed"
else
	echo "Installing Docker"
	curl -sSL https://get.docker.com | sh > /dev/null 2>&1
fi

# If  pi user is not in docker user group
if ! groups pi | grep -q 'docker'; then
	echo "Adding pi user to docker user group"
	sudo usermod -aG docker pi
fi

# If docker-compose not installed
if docker-compose -v > /dev/null 2>&1; then
	echo "docker-compose already installed."
else
	if pip -V > /dev/null 2>&1; then
		echo "pip already installed"
	else
		echo "Installing python and pip"
		sudo apt update > /dev/null 2>&1
		sudo apt install -y python python-pip > /dev/null 2>&1
	fi
	echo " Installing docker-compose"
	sudo pip install docker-compose > /dev/null 2>&1
fi

# If pi_video_matrix directory doesn't exist create it
if [ -d ~/pi_video_matrix/conf ]; then
	echo "pi_video_matrix/conf directory already exists"
else
	echo "Creating pi_video_matrix and conf directory"
	mkdir -p ~/pi_video_matrix/conf
fi

# Get docker-compose.yml
echo "Downloading docker-compose.yml to pi_video_matrix directory"
wget -qO ~/pi_video_matrix/docker-compose.yml https://github.com/oceaness/pi_video_matrix/raw/master/docker-compose.yml

# Get conf files
echo "Downloading conf files to pi_video_matrix/conf directory"
conf_files=(example.layout.conf feeds.conf pi_video_matrix.conf scheduler.conf)
for file in "${conf_files[@]}"; do
	wget -qO ~/pi_video_matrix/conf/"$file" https://github.com/oceaness/pi_video_matrix/raw/master/conf/"$file"
done

# Check if pi user password has been changed
if [ -e /run/sshwarn ] ; then
	printf "\nThe password for the user 'pi' is still the default value, please change this by running passwd\n\n"
fi

echo "Please reboot your pi for the settings to take effect"
echo "After rebooting please see the README.md files in the pi_video_matrix and conf directories for further instructions"
