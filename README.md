## JupAL - The Astrolabe Project customized version of JupyterLab

This is a public code repository of the [Astrolabe Project](http://astrolabe.arizona.edu/) at the [University of Arizona](http://www.arizona.edu).

**Author**: [Tom Hicks](https://github.com/hickst)

***Purpose**: JupAL is a special version of [JupyterLab](https://github.com/jupyterlab/jupyterlab) which has been customized by the [Astrolabe Project](http://astrolabe.arizona.edu/) at the [University of Arizona](http://www.arizona.edu). JupAL implements a JupyterLab 2 server enhanced with Python libraries, data, and notebooks for astronomy analysis and visualization. The project Makefile allows a user to easily build and run a local JupyterLab 2 server. Based on the respected [jupyter/scipy-notebook](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html), the image is enhanced with additional astronomy libraries such as Astropy, Astroquery, Pycairo, pyYAML, Pyvo, and PyWWT.*

*JupAL can connect to astronomy data and image servers running remotely. Included example JupyterLab notebooks demonstrate how to connect to the Astrolabe Virtual Observatory (VO) and Image/Cutout servers to perform queries and retrieve data for scientific analysis. The Astrolabe VO and Image/Cutout Servers are supported through CyVerse's External Collaborative Partnership program ([Cyverse Project](http://cyverse.org)).*


## Installation

***Note**: Installing JupAL requires a working Docker installation, version 19.03 or greater, and the Git and Make programs.*

### Getting the JupAL image from DockerHub

The latest JupAL image is available from the 
[ Astrolabe Docker image repository on DockerHub](https://hub.docker.com/repository/docker/astrolabe/jupal) and is easily downloaded using Docker:
```
> docker pull astrolabe/jupal
```


### Create the Data and Work directories

The Docker `run` command, contained in the project Makefile, assumes the existence of two subdirectories in the current directory: a `data` directory and a `work` directory. These directories are used by the JupAL container to access your data files and personal work notebooks. More technically, the `data` and `work` directories are *bind mounted* into the JupAL container as read-write mounts.

***Note:** The JupyterLab server, and any notebooks it runs, will have both read and write access to the mounted `data` and `work` directories and can alter or delete files in those directories.*

***Note: If they do not already exist**, you must create the `data` and `work` subdirectories, even if you do not intend to put any files into them.*

Directory creation, *if needed*, should be done before running the JupAL container for the first time, as follows:
```
mkdir data work
```

### Adding the WWT Example Notebooks (OPTIONAL)

At this point, using the Git program, you can easily add several great, example astronomy notebooks from the WorldWide Telescope (WWT) [pywwt-notebooks](https://github.com/WorldWideTelescope/pywwt-notebooks) project. The PyWWT notebooks demonstrate many uses of the included [WWT Python library](https://github.com/WorldWideTelescope/pywwt). If you decide to add the PyWWT example notebooks, they should be downloaded into the `work` directory, as follows:
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

You can use common Docker commands to monitor the status of the container. For example, the `docker container` command is useful to view the status of containers:
```
  > docker container ls -a
CONTAINER ID        IMAGE                   COMMAND                  CREATED             STATUS              PORTS                    NAMES
cb7442e2f55b        astrolabe/jupal:latest  "jupyter lab --no-br…"   3 seconds ago       Up 2 seconds        0.0.0.0:9999->8888/tcp   jupal

```
The `STATUS` column (to the right) should show "Up" for the JupAL container.


## Accessing JupyterLab

You should now be able access the JupyterLab server from within a browser on your local machine:

  - [http://localhost:9999/lab?](http://localhost:9999/lab?)


### Using the Astrolabe VO and Image/Cutout Servers

The Astrolabe Virtual Observatory and Image/Cutout servers provide API endpoints for programmatic access. These APIs are useable from within the JupyterLab notebook. The "top-level" URLs for the server APIs are:

  - **VO Server**: https://hector.cyverse.org/dals/
  - **Image/Cutout Server**: https://hector.cyverse.org/cuts/

***Note**: Examples of using the Astrolabe server endpoints are included in the Sample Notebooks, described next.*


### Sample Notebooks

The JupAL image includes several sample notebooks, located in the `example-notebooks` directory. Note that these notebooks are read-only and cannot be altered or saved:

  1. **PlotFromCuts.ipynb** - a notebook which demonstrates how to load images and cutouts from the Astrolabe Image/Cutout server using Python and [Astropy](https://www.astropy.org/).
  2. **TablesViaVO.ipynb** - a notebook which demonstrates how to query the Astrolabe VO Server to retrieve catalog data using SCS or TAP via Python and the included [Pyvo library](https://pyvo.readthedocs.io/en/latest/).
  3. **UseSimbad.ipynb** - a small notebook demonstrating a simple [Simbad](http://simbad.u-strasbg.fr/simbad/) search using Python and [Astropy](https://www.astropy.org/).

  If you installed the WorldWide Telescope notebooks (as described above), they will be located in the `work/WWT` directory. Since they are installed in the `work` directory, these notebooks can be edited, updated, and saved, should you wish to do so:

  4. **WWT Notebooks** - the JupAL image can run the example notebooks from the WorldWide Telescope [pywwt-notebooks](https://github.com/WorldWideTelescope/pywwt-notebooks) project. These beautiful notebooks demonstrate many of the capabilities of the [pywwt library](https://github.com/WorldWideTelescope/pywwt), which is included in the JupAL image.


## Stopping the local JupAL container

In order to avoid losing work, the JupAL container is best stopped **from within** JupyterLab itself. To shutdown JupyterLab, open the `File` menu in the JupyterLab menubar, and select the `Shut Down` menu item. **Be sure to save your work, from any modifed notebooks, before you shutdown JupyterLab.**

If you are unable to shutdown the JupAL container from within JupyterLab, you can, as a last resort, force the container to stop. **Forcing the container to stop is not recommended as a normal shutdown procedure because you can lose unsaved work and/or data.**

To force JupAL to stop:
```
> make stop
```
The status of the JupAL container can be monitored with the `docker container ls -a` command.


## License

This software is licensed under Apache License Version 2.0.

Copyright (c) The University of Arizona, 2019. All rights reserved.
