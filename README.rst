****************************************
Packaging Project for FogLAMP QuickStart
****************************************

This repo contains the scripts used to create a FogLAMP QuickStart package.


Building a Package
==================

It comprises:

* Download or clone the three repositories

  * git clone -b develop --single-branch https://github.com/foglamp/foglamp-gui.git
  * git clone -b develop --single-branch https://github.com/foglamp/FogLAMP.git
  * git clone https://github.com/foglamp/foglamp-south-sinusoid.git

* Install dependencies ::

                yes Y |  sudo apt-get install curl
                yes Y |  sudo apt-get install cmake g++ make build-essential autoconf automake
                yes Y |  sudo apt-get install libtool libboost-dev libboost-system-dev
                yes Y |  sudo apt-get install libboost-thread-dev libpq-dev libssl-dev
                yes Y |  sudo apt-get install python-setuptools python3-dbus python3-dev
                yes Y |  sudo apt-get install uuid-dev
                yes Y |  sudo apt-get install sqlite3 libsqlite3-dev
                yes Y | sudo apt-get install nginx-light
                curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
                yes Y | sudo apt-get install -y nodejs
                yes Y | sudo npm install -g yarn

* FogLAMP is properly installed via ``sudo make install`` somewhere on your environment (default is /usr/local/foglamp) inside FogLAMP repository

* Prepare foglamp-gui build artifacts via ``./build.sh`` inside foglamp-gui repository

**Note:** If you are lazy just run ``./prerequisite``, it will do the magic for above steps

* Create debian package, select the architecture to use, *x86* or *arm*. Finally, run the ``make_deb`` command and the package will be placed in ``packages/Debian/build/``

* Install debian package via ``sudo dpkg -i <package_name.deb>``

Cleaning the Package Folder
===========================
Use the ``clean`` option to remove all the old packages and the files used to make the package.
Use the ``cleanall`` option to remove all the packages and the files used to make the package.
