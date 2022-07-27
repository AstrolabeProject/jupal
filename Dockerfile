FROM jupyter/scipy-notebook:lab-3.4.4

COPY jupyter_server_config.json /opt/conda/etc/jupyter/jupyter_server_config.json

USER root

# Install some extras
RUN apt-get update \
    && apt-get install -y lsb gnupg curl \
    && apt-get clean \
    && rm -rf /usr/lib/apt/lists/* \
    && conda clean -tipy \
    && fix-permissions $CONDA_DIR

USER jovyan

# mount points for optional external user data and work directory with sample notebooks
RUN mkdir -p /home/jovyan/data /home/jovyan/work

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

RUN jupyter lab build

COPY /example-notebooks /home/jovyan/example-notebooks

EXPOSE 8888

ENTRYPOINT ["jupyter"]
CMD ["lab", "--no-browser"]
