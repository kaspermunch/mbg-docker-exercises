
ARG OS_TYPE=x86_64

ARG UBUNTU_VER=23.10
ARG CONDA_VER=23.10.0-1
ARG PY_VER=py38

FROM ubuntu:${UBUNTU_VER}

LABEL maintainer="Kasper Munch <kaspermunch@birc.au.dk>"

# send stdout and stderr straight to terminal
ENV PYTHONUNBUFFERED 1

# system packages 
RUN apt update && apt install -y --no-upgrade libc6 curl && apt remove --purge && rm -rf /var/lib/apt/lists/*

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

# # install packages
# RUN conda install -c bioconda -c conda-forge -c maximinio -c r -q -y \
#         git jupyterlab rpy2 r-essentials \
#         bowtie2 macs3 samtools bioconductor-chipseeker \
#         bioconductor-txdb.hsapiens.ucsc.hg38.knowngene zip ncurses \
#     && conda clean -afy     

# install packages
RUN conda install -c conda-forge -q -y \
       jupyterlab nodejs anaconda-toolbox \
    && conda clean -afy     

# EXPOSE 8888

# ENTRYPOINT ["jupyter", "lab", "--ip='*'", "--port=8888", "--no-browser", "--allow-root"]
# ENTRYPOINT ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
ENTRYPOINT ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]

#CMD []






# build:
# docker build --platform=linux/amd64 -t kaspermunch/jupyter-linux-amd64:latest .

# run interactive:
# docker run --rm -it --network=host --entrypoint /bin/bash kaspermunch/jupyter-linux-amd64:latest

# run with jupyterlab
# docker run --rm -v $(pwd):$(pwd) -w $(pwd) -i -t -p 8888:8888 kaspermunch/jupyter-linux-amd64:latest



# docker network create -d host my-net
# mac/linux
# docker network create -d host my-net
# docker run --network=my-net --rm --volume=$(pwd):$(pwd) --workdir=$(pwd) --interactive --tty --publish=8888:8888 --name=jupyter-linux kaspermunch/jupyter-linux-amd64:latest
# windows
# docker run --network=my-net --rm --volume=//c/users/$env:username://c/users/$env:username --workdir=//c/users/$env:username --interactive --tty --publish=8888:8888 --name=jupyter-linux kaspermunch/jupyter-linux-amd64:latest


