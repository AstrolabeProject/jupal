FROM jupyter/scipy-notebook

COPY jupyter_notebook_config.json /opt/conda/etc/jupyter/jupyter_notebook_config.json

USER root

# Install the icommands, curl, and wget
RUN apt-get update \
    && apt-get install -y lsb wget gnupg apt-transport-https python3.7 python-requests curl \
    && apt-get clean \
    && rm -rf /usr/lib/apt/lists/* \
    && fix-permissions $CONDA_DIR


USER jovyan

# install foundational jupyter lab and tools
RUN conda update -n base conda
RUN conda install jupyterlab=1.2.1 \
    && conda install -c conda-forge ipywidgets \
    && conda install -c astropy astroquery \
    && conda clean -tipsy \
    && fix-permissions $CONDA_DIR

# install jupyter hub and extra doodads
RUN jupyter lab --version \
    && jupyter labextension install @jupyter-widgets/jupyterlab-manager@1.1

# install other PIP packages
# RUN pip install pyvo firefly_client
RUN pip install pyvo

# mount points for optional external user data and work volumes
RUN mkdir -p /home/jovyan/data /home/jovyan/work

ENTRYPOINT ["jupyter"]
CMD ["lab", "--no-browser"]
