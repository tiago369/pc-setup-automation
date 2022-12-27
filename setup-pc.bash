#!/bin/bash

# chmod +x setup-pc.bash
# ./setup-pc.bash

#Made for Ubuntu 20.04

# Run as superuser
sudo -n true

# Aks for programs
USER=tiago
terminator=false
alacritty=true
git=true
vscode=true
brave=true
element=false
noetic=false
foxy=true
docker=true
latex=false
cv2=true
unity=true

if $unity ; then
  sudo sh -c 'echo "deb https://hub.unity3d.com/linux/repos/deb stable main" > /etc/apt/sources.list.d/unityhub.list'
  wget -qO - https://hub.unity3d.com/linux/keys/public | sudo apt-key add -
  sudo apt update
  sudo apt-get install unityhub -y
fi

if $alacritty ; then
  sudo add-apt-repository ppa:mmstick76/alacritty
  sudo curl https://sh.rustup.rs -sSf | sh
  cd
  git clone https://github.com/jwilm/alacritty.git
  cd alacritty
  cargo build --release
  sudo cp target/release/alacritty /usr/local/bin
  sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
  sudo desktop-file-install extra/linux/Alacritty.desktop
  sudo update-desktop-database
  sudo mkdir -p /usr/local/share/man/man1
  gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
  echo "source $(pwd)/extra/completions/alacritty.bash" >> ~/.bashrc
fi

# Install git
if $git ; then
  sudo apt-get install git -y
fi

# Install terminator
if $terminator ; then
  sudo apt install terminator -y
fi


# Install vscode
if $vscode ; then
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
  sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
  rm -f packages.microsoft.gpg
  sudo apt install apt-transport-https -y
  sudo apt update
  sudo apt install code -y
fi

# Install Brave
if $brave ; then
  sudo apt install apt-transport-https curl -y
  sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
  sudo apt update
  sudo apt install brave-browser -y
fi

# Install element
if $element ; then
  sudo apt install -y wget apt-transport-https
  sudo wget -O /usr/share/keyrings/element-io-archive-keyring.gpg https://packages.element.io/debian/element-io-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/element-io-archive-keyring.gpg] https://packages.element.io/debian/ default main" | sudo tee /etc/apt/sources.list.d/element-io.list
  sudo apt update
  sudo apt install element-desktop -y
fi

# Install ROS Noetic
if $noetic ; then
  sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
  sudo apt install curl -y
  curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
  sudo apt update
  sudo apt install ros-noetic-desktop-full -y
  # source /opt/ros/noetic/setup.bash
  # echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
  # source ~/.bashrc
  sudo apt install python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential -y
  sudo apt install python3-rosdep -y
  sudo rosdep init
  rosdep update
fi

# Installing ROS 2 Foxy
if $foxy ; then
  locale  # check for UTF-8
  sudo apt update && sudo apt install locales -y
  sudo locale-gen en_US en_US.UTF-8
  sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
  export LANG=en_US.UTF-8
  locale  # verify settings

  sudo apt install software-properties-common -y
  sudo add-apt-repository universe

  sudo apt update && sudo apt install curl -y
  sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

  sudo apt update
  sudo apt upgrade
  sudo apt install ros-foxy-desktop python3-argcomplete -y
  sudo apt install ros-dev-tools -y
fi

# Install docker
if $docker ; then
  sudo apt-get update
  sudo apt-get install -y \
      ca-certificates \
      curl \
      gnupg \
      lsb-release
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  sudo chmod a+r /etc/apt/keyrings/docker.gpg
  sudo apt-get update
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
  sudo groupadd docker
  sudo usermod -aG docker $USER
  newgrp docker
fi

# Install latex
if $latex ; then
  sudo add-apt-repository ppa:jonathonf/texlive
  sudo apt update   
  sudo apt install -y texlive-full
  tlmgr install -y abntex2        
  tlmgr update abntex2
  tlmgr init-usertree
fi

# # Install Opencv
if $cv2 ; then
sudo apt update
sudo apt install -y libopencv-dev python3-opencv
python3 -c "import cv2; print(cv2.__version__)"
fi

# Install tweaks
if $tweaks ; then
sudo apt install -y gnome-tweaks
sudo apt install -y gnome-tweak-tool
cd %% mkdir ~/.themes
cd && mkdir ./icons
sudo apt install -y dconf-editor
fi
