#!/bin/bash

# chmod +x setup-pc.bash
# ./setup-pc.bash

#Made for Ubuntu 20.04

#Install terminator
sudo apt install terminator

#Install git
sudo apt-get install git

#Install vscode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https
sudo apt update
sudo apt install code

#Install Brave
sudo apt install apt-transport-https curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser

#Install element
sudo apt install -y wget apt-transport-https
sudo wget -O /usr/share/keyrings/element-io-archive-keyring.gpg https://packages.element.io/debian/element-io-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/element-io-archive-keyring.gpg] https://packages.element.io/debian/ default main" | sudo tee /etc/apt/sources.list.d/element-io.list
sudo apt update
sudo apt install element-desktop

#Install ROS Noetic
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt install curl
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
sudo apt update
sudo apt install ros-noetic-desktop-full
source /opt/ros/noetic/setup.bash
echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
source ~/.bashrc
sudo apt install python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential
sudo apt install python3-rosdep
sudo rosdep init
rosdep update

#Install docker
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

#Install latex
sudo add-apt-repository ppa:jonathonf/texlive
sudo apt update   
sudo apt install texlive-full
tlmgr install abntex2        
tlmgr update abntex2
tlmgr init-usertree

# Install Opencv
sudo apt update
sudo apt install libopencv-dev python3-opencv
python3 -c "import cv2; print(cv2.__version__)"

# Install telegram
wget "https://telegram.org/dl/desktop/linux" -O telegram.tar.xz
sudo tar -xvf telegram.tar.xz -C /opt
sudo mv /opt/Telegram /opt/telegram-desktop
sudo ln -sf /opt/telegram-desktop/Telegram /usr/bin/telegram
echo -e '\n[Desktop Entry]\nName=Telegram\nExec=/opt/telegram-desktop/Telegram\nIcon=/opt/telegram-desktop/Telegram\nType=Application\nCategories=Network;InstantMessaging;' | sudo tee /usr/share/applications/telegram.desktop

# Install Whatsapp 
sudo snap install whatsie

# Install tweaks
sudo apt install gnome-tweaks
sudo apt install gnome-tweak-tool
cd %% mkdir ~/.themes
cd && mkdir ./icons
sudo apt install dconf-editor

# Install todoist
sudo snap install todoist