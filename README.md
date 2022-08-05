## JupAL - The Astrolabe Project customized version of JupyterLab

This is a public code repository of the Astrolabe Project at the [University of Arizona](http://www.arizona.edu).

**Author**: [Tom Hicks](https://github.com/hickst)

***Purpose**: JupAL is a special version of [JupyterLab](https://github.com/jupyterlab/jupyterlab) which has been customized by the Astrolabe Project at the [University of Arizona](http://www.arizona.edu). JupAL implements a JupyterLab 3 server enhanced with Python libraries and notebooks for astronomy analysis and visualization. Based on the respected [jupyter/scipy-notebook](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html), this image includes additional astronomy libraries such as Astropy, Astroquery, Pyvo, and PyWWT.*

* JupAL includes libraries which can connect to both public and private astronomy data and image servers running remotely. The included example JupyterLab notebooks demonstrate how authorized JWST project members can connect to the Astrolabe / JWST server to perform queries and retrieve data for scientific analysis. The Astrolabe / JWST Server is supported through CyVerse's External Collaborative Partnership program ([Cyverse Project](http://cyverse.org)).*

***Note**: Installing JupAL requires a working Docker installation and the Git and Make programs. It has been tested with Docker version 20.10 but older versions may also work.*

## Quick Start Installation

### Download this Project (ONCE)

The easiest way to use the JupAL container is to download this JupAL project from GitHub and use the project Makefile to start and stop the container. To do so, first move to a convenient work area (somewhere under your home directory) and clone (download) the project to your local disk. Then move into the `jupal` directory:

```
> cd myworkdir
> git clone https://github.com/AstrolabeProject/jupal.git
> cd jupal
```

### Get the JupAL Docker Image from DockerHub (ONCE)

The latest JupAL container image is available from the 
[ Astrolabe Docker image repository on DockerHub](https://hub.docker.com/repository/docker/astrolabe/jupal) and is easily downloaded using Docker:
```
> docker pull astrolabe/jupal
```

***Note:** The JupAL Docker image includes a lot of useful software. Thus, it is very large and may take several minutes to download. But you only need to do this step once, so please be patient.*


### Setup the Data and Work directories (ONCE)

The default `run` command, implemented in the project Makefile, requires the existence of two subdirectories in the current directory: a `data` directory and a `work` directory. You provide JupyterLab access to your data files and work notebooks through these directories. Any data files and notebooks that you wish to work with in JupyterLab should be placed in these directories. If you create new notebooks from within JupyterLab, you should be sure to save them into the `work` directory (or a subdirectory of `work`) before exiting.

***Note:** The JupyterLab server, and any notebooks it runs, will have both read and write access to the mounted `data` and `work` directories and can alter or delete files in those directories. (More technically, the `data` and `work` directories are **bind mounted** into the JupAL container as read-write mounts.)*

If you use the `make run` command, empty `data` and `work` subdirectories will be automatically created if they do not already exist. If, however, you wish to create and fill the `data` and `work` directories before starting JupAL for the first time, you can create the directories manually at the command line (ONCE):
```
> mkdir data work
# now copy data and/or notebooks into the directories
```

### Adding the WWT Example Notebooks (OPTIONAL)

The JupAL software includes the latest `pywwt` library from the [WorldWide Telescope](http://www.worldwidetelescope.org/home/) project. If you want to explore this project, you can use the Git program to easily add several of their great, example notebooks: [pywwt-notebooks](https://github.com/WorldWideTelescope/pywwt-notebooks). The PyWWT notebooks demonstrate many uses of the included [WWT Python library](https://github.com/WorldWideTelescope/pywwt). If you decide to add the PyWWT example notebooks, they should be downloaded into the `work` directory, as follows:
```
> cd work
> git clone https://github.com/WorldWideTelescope/pywwt-notebooks.git WWT
> cd ..
```

## Running the Astrolabe JupAL container

Once the JupAL image is available on your local host, and you have ensured that the `data` and `work` directories are present, you may start the server using the project Makefile:
```
  > make run
```
Wait a few seconds for the container to initialize. By default, the JupAL container instance runs on port 9999, so you should ignore the JupyterLab startup messages which mention different ports and URLs.

If you are familiar with Docker, you can use common Docker commands to monitor the status of the container. For example, the `docker container` command is useful to view the status of containers:
```
  > docker container ls -a
CONTAINER ID        IMAGE                   COMMAND                  CREATED             STATUS              PORTS                    NAMES
cb7442e2f55b        astrolabe/jupal:latest  "jupyter lab --no-br…"   3 seconds ago       Up 2 seconds        0.0.0.0:9999->8888/tcp   jupal

```
The `STATUS` column (to the right) should show "Up" for the JupAL container within a minute or so.


## Accessing JupyterLab

You should now be able access the JupyterLab server from within a browser on your local machine:

  - [http://localhost:9999/lab?](http://localhost:9999/lab?)


### Using the Astrolabe / JWST Server (JWST PROJECT MEMBERS ONLY)

The private AL/JWST Server provides API endpoints for programmatic access by authorized JWST project members. This API is useable from within the JupyterLab notebook by users who have login credentials.

***Note**: Examples of using the AL/JWST server endpoints are included in the sample notebooks, described next.*

### Sample Notebooks

The JupAL image includes several sample notebooks, located in the `example-notebooks` directory. Note that these notebooks are read-only and cannot be altered or saved. You can, however, copy them or modify and save them into your work area.

  1. **PlotFromALWS.ipynb** - a notebook which demonstrates how to query, fetch, and display images and cutouts from the AL/JWST Server using Python and [Astropy](https://www.astropy.org/).
  2. **CatalogsFromALWS.ipynb** - a notebook which demonstrates how to query the AL/JWST Server to retrieve catalog data via Python and Astropy.
  3. **ALWS_utils.ipynb** - this notebook is imported and used by the previous two notebooks. It provides a helper class to interface with the AL/JWST Server API. You should not need to open or modify it.
  4. **UseSimbad.ipynb** - a small notebook demonstrating a simple [Simbad](http://simbad.u-strasbg.fr/simbad/) search using Python and Astropy.

  If you installed the optional WorldWide Telescope notebooks (as described above), they will be located in the `work/WWT` directory. Since they are installed in the `work` directory, these notebooks can be edited, updated, and saved, should you wish to do so:

  5. **WWT Notebooks** - the JupAL image can run the example notebooks from the WorldWide Telescope [pywwt-notebooks](https://github.com/WorldWideTelescope/pywwt-notebooks) project. These beautiful notebooks demonstrate many of the capabilities of the [pywwt library](https://github.com/WorldWideTelescope/pywwt), which is included in the JupAL image.


## Stopping the local JupAL container

In order to avoid losing work, the JupAL container is best stopped **from within**
JupyterLab itself. **Be sure to save your work, from any modifed notebooks, before you
shut down JupyterLab.**

 To shut down JupyterLab, open the `File` menu in the JupyterLab menubar, and select the `Shut Down` menu item.

If you are unable to shut down the JupAL container from within JupyterLab, you can, as a
last resort, force the container to stop. **Forcing the container to stop is not
recommended as a normal shut down procedure because you can lose unsaved work and/or data.**

To force JupAL to stop:
```
> make stop
```
The status of the JupAL container can be monitored with the `docker container ls -a` command.


## License

This software is licensed under Apache License Version 2.0.

Copyright (c) The University of Arizona, 2019. All rights reserved.
