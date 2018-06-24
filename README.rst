.. Links
.. _foglamp repository: https://github.com/foglamp/FogLAMP
.. _foglamp-gui repository: https://github.com/foglamp/foglamp-gui.git
.. _foglamp-south-plugin repository: https://github.com/foglamp/foglamp-south-sinusoid.git

****************************************
Packaging Project for FogLAMP QuickStart
****************************************

This repo contains the scripts used to create a FogLAMP QuickStart package.


The make_deb Script
===================

.. code-block:: console

   $ ./make_deb --help
   make_deb {x86|arm} [clean|cleanall]
   This script is used to create the Debian package of FogLAMP QuickStart
   Arguments:
     x86      - Build an x86_64 package
     arm      - Build an armv7l package
     clean    - Remove all the old versions saved in format .XXXX
     cleanall - Remove all the versions, including the last one


Building QuickStart Package
===========================

* Clone (or download) the following repositories

  .. code-block:: console

     git clone -b develop --single-branch https://github.com/foglamp/foglamp-gui.git
     git clone -b develop --single-branch https://github.com/foglamp/FogLAMP.git
     git clone https://github.com/foglamp/foglamp-south-sinusoid.git

* Install dependencies

  .. code-block:: console

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

* Make sure that FogLAMP is properly installed via ``make install`` somewhere on your environment (default ``FOGLAMP_ROOT`` path environment variable value is ``/usr/local/foglamp``).

* Prepare foglamp-gui build artifacts via ``./build.sh`` inside the foglamp-gui repository

    .. note:: If you are lazy enough, just run ``./prerequisite``, it will do the magic for all the above (4) steps! see ``./prerequisite --help`` for more options.

* Run the ``./make_deb {x86|arm}`` command, the package will be placed in ``packages/Debian/build/``

* Install the debian package via ``sudo dpkg -i foglamp-quickstart-<ver>-<arch>.deb``


Cleaning the Package Directory
==============================
* Use the ``clean`` option to remove all the old packages and the files used to make the package.

* Use the ``cleanall`` option to remove all the packages and the files used to make the package.
