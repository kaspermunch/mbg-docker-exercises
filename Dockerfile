
ARG GITHUB_REPO=mbg-docker-exercises

ARG OS_TYPE=x86_64
ARG UBUNTU_VER=23.10
ARG CONDA_VER=23.10.0-1

ARG PY_VER=py38
# ARG PY_VER=py39
# ARG PY_VER=py310
# ARG PY_VER=py311
# ARG PY_VER=py312

# base image
FROM ubuntu:${UBUNTU_VER}

LABEL maintainer="Kasper Munch <kaspermunch@birc.au.dk>"

# send stdout and stderr straight to terminal
ENV PYTHONUNBUFFERED 1

# centally installed system packages. Always install curl and lib6
# (this is where you install any packages required for compilation 
# like build-essential libc6-dev libpthread-stubs0-dev)
RUN apt update \
    && apt install -y --no-upgrade libc6 curl \
    && apt remove --purge && rm -rf /var/lib/apt/lists/*

# # use the above args during building 
# https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact
ARG CONDA_VER
ARG OS_TYPE
ARG PY_VER
# Install miniconda to /miniconda
RUN curl -LO "http://repo.continuum.io/miniconda/Miniconda3-${PY_VER}_${CONDA_VER}-Linux-${OS_TYPE}.sh" \
    && bash Miniconda3-${PY_VER}_${CONDA_VER}-Linux-${OS_TYPE}.sh -p /miniconda -b \
    && rm Miniconda3-${PY_VER}_${CONDA_VER}-Linux-${OS_TYPE}.sh
ENV PATH=/miniconda/bin:${PATH}
RUN conda init

#############################################################

# install packages for Magdalena's exercise (REQUIRES python 3.8)
RUN conda update -n base conda \
    && conda install -n base -c bioconda -c conda-forge -c maximinio -c r -q -y \
        git jupyterlab jupyterlab-git rpy2 r-essentials \
        bowtie2 macs3 samtools bioconductor-chipseeker \
        bioconductor-txdb.hsapiens.ucsc.hg38.knowngene zip ncurses \
        openssh \
    && conda config --set solver libmamba \
    && conda clean -afy     

#RUN conda env update --name base --file ${GITHUB_REPO}/binder/environmnet.yml --prune && conda clean -afy



# run in bash to activate base environment
ENTRYPOINT ["/bin/bash", "-c", "git clone git@github.com:kaspermunch/mbg-docker-exercises.git ; jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root"]

# docker run --rm -v $HOME/.ssh:/root/.ssh -v $HOME/.anaconda:/root/.anaconda -v $(pwd):$(pwd) -w $(pwd) -i -t -p 8888:8888 kaspermunch/jupyter-linux-amd64:latest 

#############################################################

# # install juptyer and anaconda-toolbox
# RUN conda update -n base conda
# RUN conda install -c anaconda -c conda-forge -q -y \
#         'jupyter_server<2' \
#         jupyterlab ipython nodejs anaconda-toolbox anaconda-cloud-auth anaconda-cloud clyent \
#     && conda clean -afy     

# # run in bash to activate base environment
# ENTRYPOINT ["/bin/bash", "-c", "jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root"]

#############################################################

# # install juptyer and anaconda-toolbox
# RUN conda update -n base conda
# RUN conda install -c anaconda -c conda-forge -c plotly -c kaspermunch  -q -y popgen-dashboards=1.1.5 \
#     && conda clean -afy     

# # run in bash to activate base environment
# ENTRYPOINT ["/bin/bash", "-c", "arg-dashboard --ip='0.0.0.0'"]

#############################################################

# # install juptyer and anaconda-toolbox'
# RUN conda update -n base conda
# RUN conda install -c anaconda -c conda-forge -q -y jupyterlab anaconda-toolbox \
#     && conda clean -afy   

# # run in bash to activate base environment
# ENTRYPOINT ["/bin/bash", "-c", "jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root"]

#############################################################

# # PG for popgen-dashboards
# RUN conda update -n base conda
# RUN conda install -c anaconda -c conda-forge -c plotly -c kaspermunch -q -y \
#        jupyterlab ipython nodejs notebook ipympl ipython seaborn statsmodels popgen-dashboards \
#     && conda clean -afy 

# # run in bash to activate base environment
# ENTRYPOINT ["/bin/bash", "-c", "jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root"]

#############################################################



# ENTRYPOINT ["/bin/bash", "-c", "jupyter lab --ip='*' --port=8888 --no-browser --allow-root"]

# ENTRYPOINT ["/bin/bash", "-c", "anaconda login --basic anaconda.cloud && jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root"]
# ENTRYPOINT ["/bin/bash", "-c", "mkdir -p ~/.anaconda && cp /userhome/.anaconda/keyring ~/.anaconda && jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root"]


# run container interactively:
#docker run --rm -v $(pwd):$(pwd)  -it --entrypoint /bin/bash kaspermunch/jupyter-linux-amd64:latest

# produce conda environment file from container:
# docker run --rm -it --entrypoint /bin/bash kaspermunch/jupyter-linux-amd64:latest -c 'conda run -n base conda env export' > environment.yml


# build
# docker build --platform=linux/amd64 -t kaspermunch/jupyter-linux-amd64:latest .

# jupyter mac
# docker run --rm -v $HOME/.anaconda:/root/.anaconda -v $(pwd):$(pwd) -w $(pwd) -i -t -p 8888:8888 kaspermunch/jupyter-linux-amd64:latest 
# jupyter windows
# docker run --rm -v //c/users/$env:username/.anaconda:/root/.anaconda -v //c/users/$env:username://c/users/$env:username -i -t -p 8888:8888 kaspermunch/jupyter-linux-amd64:latest 

# bash mac
# docker run --rm -v $HOME/.anaconda:/root/.anaconda -v $(pwd):$(pwd) -w $(pwd) -i -t -p 8888:8888 kaspermunch/jupyter-linux-amd64:latest 

# push
# docker push kaspermunch/jupyter-linux-amd64:latest

# docker search docker hub for images:
# docker search kaspermunch/jupyter-

# get versions of an image
# wget -q -O - "https://hub.docker.com/v2/namespaces/kaspermunch/repositories/jupyter-linux-amd64/tags?page_size=100" | grep -o '"name": *"[^"]*' | grep -o '[^"]*$'





#$PWD -replace '\\', '/'
#$path.Replace("\", "/").Replace("C:", "//c")