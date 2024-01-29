
ARG OS_TYPE=x86_64

ARG UBUNTU_VER=23.10
ARG CONDA_VER=23.10.0-1
ARG PY_VER=py38

FROM ubuntu:${UBUNTU_VER}

LABEL maintainer="Kasper Munch <kaspermunch@birc.au.dk>"

# send stdout and stderr straight to terminal
ENV PYTHONUNBUFFERED 1

# system packages 
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

# # install packages for Magdalena's exercise
# RUN conda install -c bioconda -c conda-forge -c maximinio -c r -q -y \
#         git jupyterlab rpy2 r-essentials \
#         bowtie2 macs3 samtools bioconductor-chipseeker \
#         bioconductor-txdb.hsapiens.ucsc.hg38.knowngene zip ncurses \
#     && conda clean -afy     

# install juptyer and anaconda-toolbox
RUN conda install -c conda-forge -q -y \
       jupyterlab ipython nodejs anaconda-toolbox \
    && conda clean -afy     

# openssl genrsa -out certificate.key 4096
# openssl req -new -x509 -text -key certificate.key -out certificate.crt

# # Copy the SSL certificate files into the image
# COPY certificate.crt /etc/nginx/certs/certificate.crt
# COPY certificate.key /etc/nginx/certs/certificate.key
# # Configure Nginx to use the SSL certificate
# RUN mkdir -p /etc/nginx/conf.d
# RUN echo "server { \
#     listen 443 ssl; \
#     server_name example.com; \
#     ssl_certificate /etc/nginx/certs/certificate.crt; \
#     ssl_certificate_key /etc/nginx/certs/certificate.key; \
#     location / { \
#         root /usr/share/nginx/html; \
#         index index.html index.htm; \
#     } \
# }" > /etc/nginx/conf.d/default.conf

###########################################################
ENTRYPOINT ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.ip=192.168.65.1"]

# build:
# docker build --platform=linux/amd64 -t kaspermunch/jupyter-linux-amd64:latest .

# run interactive:
# docker run --rm -it --network=host --entrypoint /bin/bash kaspermunch/jupyter-linux-amd64:latest

# run with jupyterlab
# docker run --rm -v $(pwd):$(pwd) -w $(pwd) -i -t -p 8888:8888 kaspermunch/jupyter-linux-amd64:latest


###########################################################


# ENTRYPOINT ["jupyter", "lab", "--port=8888", "--no-browser", "--allow-root"]
# ENTRYPOINT ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
# ENTRYPOINT ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.allow_origin='*'"]
# ENTRYPOINT ["jupyter", "lab", "--ip=*", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.allow_origin='*'"]

# ENTRYPOINT ["jupyter", "lab", "--ip=*", "--port=8888", "--no-browser", "--allow-root"]
# ENTRYPOINT ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
# ENTRYPOINT ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
# ENTRYPOINT ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
# ENTRYPOINT ["jupyter", "lab", "--ip=host.docker.internal", "--port=8888", "--no-browser", "--allow-root"]
# ENTRYPOINT ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.local_hostnames=[host.docker.internal]"]

#CMD []




###########################################################



# build:
# docker build --platform=linux/amd64 -t kaspermunch/jupyter-linux-amd64:latest .

# run interactive:
# docker run --rm -it --network=host --entrypoint /bin/bash kaspermunch/jupyter-linux-amd64:latest

# run with jupyterlab
# docker run --rm -v $(pwd):$(pwd) -w $(pwd) -i -t -p 8888:8888 kaspermunch/jupyter-linux-amd64:latest



# docker network create -d host my-net
# mac/linux
# docker network create -d host my-net
# docker run --network=host --rm --volume=$(pwd):$(pwd) --workdir=$(pwd) --interactive --tty --name=jupyter-linux kaspermunch/jupyter-linux-amd64:latest
# windows
# docker run --network=host --rm --volume=//c/users/$env:username://c/users/$env:username --workdir=//c/users/$env:username --interactive --tty --name=jupyter-linux --name=jupyter-linux kaspermunch/jupyter-linux-amd64:latest




# docker build --network=host --platform=linux/amd64 -t kaspermunch/jupyter-linux-amd64:latest .