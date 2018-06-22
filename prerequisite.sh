#!/usr/bin/env bash
set -e

__author__="Ashish Jabble"
__copyright__="Copyright (c) 2017-18 DIANOMIC SYSTEMS"
__license__="Apache 2.0"
__version__="1.0.0"


yes Y |  sudo apt-get update
yes Y |  sudo apt-get upgrade

yes Y |  sudo apt-get install curl

yes Y |  sudo apt-get install cmake g++ make build-essential autoconf automake
yes Y |  sudo apt-get install libtool libboost-dev libboost-system-dev libboost-thread-dev libpq-dev libssl-dev
yes Y |  sudo apt-get install python-setuptools python3-dbus python3-dev python3-pip

yes Y |  sudo apt-get install uuid-dev

yes Y |  sudo apt-get install sqlite3 libsqlite3-dev

yes Y | sudo apt-get install nginx-light

curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
yes Y | sudo apt-get install -y nodejs
yes Y | sudo npm install -g yarn

#####################################################
# Clone FogLAMP, foglamp-gui, foglamp-south-sinusoid
####################################################

GIT_ROOT=`pwd`
git clone -b develop --single-branch https://github.com/foglamp/FogLAMP.git
git clone -b develop --single-branch https://github.com/foglamp/foglamp-gui.git
git clone https://github.com/foglamp/foglamp-south-sinusoid.git

# FogLAMP install
cd ${GIT_ROOT}/FogLAMP
sudo make install
cd ..

# Prepare foglamp-gui build artifacts
cd ${GIT_ROOT}/foglamp-gui
rm -rf dist
./build.sh
cd ..
