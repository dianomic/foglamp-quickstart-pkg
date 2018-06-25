****************************************
Packaging Project for FogLAMP QuickStart
****************************************

This repo contains the scripts used to create a FogLAMP QuickStart package.


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
     yes Y |  sudo apt-get install python3-setuptools python3-dbus python3-dev
     yes Y |  sudo apt-get install uuid-dev
     yes Y |  sudo apt-get install sqlite3 libsqlite3-dev

     yes Y | sudo apt-get install nginx-light
     curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
     yes Y | sudo apt-get install -y nodejs
     yes Y | sudo npm install -g yarn

* Make sure that FogLAMP is properly installed via ``make install`` somewhere on your environment (default path value for ``FOGLAMP_ROOT`` environment variable is ``/usr/local/foglamp``).

* Prepare foglamp-gui build artifacts via ``./build --clean-start`` inside the foglamp-gui repository

    .. note:: If you are lazy enough, just run ``./prerequisite``, it will do the magic for all the above (4) steps! see ``./prerequisite --help`` for more options.

* Run the ``./make_deb {x86|arm}`` command, the package will be placed in ``packages/Debian/build/``

The make_deb Script
===================

.. code-block:: console

   $ ./make_deb help
   make_deb {x86|arm} [clean|cleanall]
   This script is used to create the Debian package of FogLAMP QuickStart
   Arguments:
     x86      - Build an x86_64 package
     arm      - Build an armv7l package
     clean    - Remove all the old versions saved in format .XXXX
     cleanall - Remove all the versions, including the last one


.. code-block:: console

    $ ./make_deb arm
    The package root directory is                    : /home/foglamp/foglamp-quickstart-pkg
    The FogLAMP QuickStart version is                : 1.0.0
    The FogLAMP directory is                         : /home/foglamp/FogLAMP
    The FogLAMP version is                           : 1.2
    The FogLAMP GUI version is                       : 1.3.0
    The FogLAMP south plugin sinusoid version is     : 1.0.0
    The Package will be built in                     : /home/foglamp/foglamp-quickstart-pkg/packages/Debian/build
    The architecture is set as                       : armhf
    The package name is                              : foglamp-quickstart-1.0.0-armhf

    Populating the package and updating version in control file...
    Done.
    ...
    Building the new package...
    dpkg-deb: building package 'foglamp-quickstart' in 'foglamp-quickstart-1.0.0-armhf.deb'.
    Building Complete.


Installing QuickStart Package
=============================

* Once you have created the package (inside ``packages/Debian/build/``), install it using the ``apt-get`` command. You can use ``apt-get`` to install a local Debian package and automatically retrieve all the necessary packages that are defined as pre-requisites for FogLAMP QuickStart.  Note that you may need to install the package as superuser (or by using the ``sudo`` command) and move the package to the apt cache directory first (``/var/cache/apt/archives``).

We recommend to execute an *update-upgrade-update* of the system first, then you may copy the foglamp-quickstart package in the *apt cache* directory and install it.

.. code-block:: console

  $ sudo apt update
  ...
  $ sudo apt upgrade
  ...
  $ sudo apt update
  ...
  $ sudo cp foglamp-quickstart-1.0.0-armhf.deb /var/cache/apt/archives/.
  ...
  $ sudo apt install /var/cache/apt/archives/foglamp-quickstart-1.0.0-armhf.deb
  ...
    Successfully installed aiohttp-2.3.8 aiohttp-cors-0.5.3 async-timeout-3.0.0 cchardet-2.1.1 chardet-3.0.4 idna-2.7 multidict-4.3.1 psycopg2-2.7.1 pyjq-2.1.0 pyjwt-1.6.0 six-1.11.0 typing-3.6.4 yarl-1.2.6
    Resolving data directory
    Data directory does not exist. Using new data directory
    Installing service script
    Generating certificate files
    Certificate files do not exist. Generating new certificate files.
    Creating a self signed SSL certificate ...
    Certificates created successfully, and placed in data/etc/certs
    Setting ownership of FogLAMP files
    Enabling FogLAMP service
    foglamp.service is not a native service, redirecting to systemd-sysv-install.
    Executing: /lib/systemd/systemd-sysv-install enable foglamp
    Starting FogLAMP service
    Adding FogLAMP south plugin
    {"name": "sinusoid", "id": "18b0fb6d-f4c0-4c53-aea1-71f782feb26d"}
    Starting FogLAMP GUI
       Active: active (running) since Mon 2018-06-25 06:52:42 UTC; 11min ago


Check the newly installed package:

.. code-block:: console

  $ sudo dpkg -l | grep foglamp-quickstart
  ii  foglamp-quickstart            1.0.0             armhf        It contains the core FogLAMP, the sinusoid south plugin and the GUI.
  $

You can also check the foglamp service currently running:

.. code-block:: console

  $ sudo systemctl status foglamp.service
  ● foglamp.service - LSB: FogLAMP
   Loaded: loaded (/etc/init.d/foglamp; generated; vendor preset: enabled)
   Active: active (running) since Mon 2018-06-25 07:04:25 UTC; 6min ago
     Docs: man:systemd-sysv-generator(8)
  Process: 5028 ExecStart=/etc/init.d/foglamp start (code=exited, status=0/SUCCESS)
   CGroup: /system.slice/foglamp.service
           ├─5093 python3 -m foglamp.services.core
           ├─5105 /usr/local/foglamp/services/storage --address=0.0.0.0 --port=43927
           ├─5163 /bin/sh services/south --port=43927 --address=127.0.0.1 --name=sinusoid
           └─5164 python3 -m foglamp.services.south --port=43927 --address=127.0.0.1 --name=sinusoid

  $

Check if FogLAMP is up and running with the ``foglamp`` command:

.. code-block:: console

  $ /usr/local/foglamp/bin/foglamp status
  FogLAMP v1.2 running.
  FogLAMP Uptime:  162 seconds.
  FogLAMP records: 0 read, 0 sent, 0 purged.
  FogLAMP does not require authentication.
  === FogLAMP services:
  foglamp.services.core
  foglamp.services.south --port=43927 --address=127.0.0.1 --name=sinusoid
  === FogLAMP tasks:
  $

You can also check nginx service currently running:

.. code-block:: console

   $ sudo service nginx status | grep active 2>&1
         Active: active (running) since Mon 2018-06-25 06:52:42 UTC; 23min ago


.. note:: Congratulations! This is all you need to do, FogLAMP-QuickStart is ready to run.

   Access ``http://<raspberry.local>`` Or use IP of the machine on which quickstart debian package is installed.


Uninstalling the Debian Package
===============================
Use the ``apt`` or the ``apt-get`` command to uninstall FogLAMP QuickStart:

.. code-block:: console

  $ sudo apt remove foglamp-quickstart
    Reading package lists... Done
    Building dependency tree
    Reading state information... Done
    The following packages were automatically installed and are no longer required:
      cmake cmake-data libarchive13 libboost-atomic1.62-dev libboost-atomic1.62.0 libboost-chrono1.62-dev libboost-chrono1.62.0
      libboost-date-time1.62-dev libboost-date-time1.62.0 libboost-dev libboost-serialization1.62-dev libboost-serialization1.62.0
      libboost-system-dev libboost-system1.62-dev libboost-thread-dev libboost-thread1.62-dev libboost-thread1.62.0 libboost1.62-dev
      libdbus-glib-1-2 libexpat1-dev libjsoncpp1 liblzo2-2 libnginx-mod-http-echo libpq-dev libpq5 libpython3-dev libpython3.5-dev libsqlite3-dev
      libssl-dev libuv1 nginx-common nginx-light python-pip-whl python-pkg-resources python3-setuptools python3-dbus python3-dev python3-pip
      python3.5-dev sqlite3 uuid-dev
    Use 'sudo apt autoremove' to remove them.
    The following packages will be REMOVED:
      foglamp-quickstart
    0 upgraded, 0 newly installed, 1 to remove and 0 not upgraded.
    After this operation, 0 B of additional disk space will be used.
    Do you want to continue? [Y/n] Y
    (Reading database ... 51296 files and directories currently installed.)
    Removing foglamp-quickstart (1.0.0) ...
    dpkg-query: package 'foglamp' is not installed
    Use dpkg --info (= dpkg-deb --info) to examine archive files,
    and dpkg --contents (= dpkg-deb --contents) to list their contents.
    Remove python cache files.
    Disable FogLAMP service.
    foglamp.service is not a native service, redirecting to systemd-sysv-install.
    Executing: /lib/systemd/systemd-sysv-install disable foglamp
    Remove FogLAMP service script
    Reset systemctl
    Stop nginx service
    dpkg: warning: while removing foglamp-quickstart, directory '/usr/local/foglamp' not empty so not removed

Cleaning the Package Directory
==============================
* Use the ``clean`` option to remove all the old packages and the files used to make the package.

* Use the ``cleanall`` option to remove all the packages and the files used to make the package.
