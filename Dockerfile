FROM jupyter/scipy-notebook:45bfe5a474fa

COPY jupyter_notebook_config.json /opt/conda/etc/jupyter/jupyter_notebook_config.json

USER root

# Install some extras curl, and wget
RUN apt-get update \
    && apt-get install -y lsb gnupg curl \
    && apt-get clean \
    && rm -rf /usr/lib/apt/lists/* \
    && fix-permissions $CONDA_DIR


USER jovyan

# display Conda version and update
RUN conda info
RUN conda update -c default -n base conda

# install extra libraries
RUN conda install -c conda-forge astropy astroquery pycairo pyYAML \
    && conda install -c conda-forge pywwt \
    && conda clean -tipy \
    && fix-permissions $CONDA_DIR

# install other PIP packages
RUN pip install pyvo

# mount points for optional external user data and work directory with sample notebooks
RUN mkdir -p /home/jovyan/data /home/jovyan/work

EXPOSE 8888

ENTRYPOINT ["jupyter"]
CMD ["lab", "--no-browser"]
