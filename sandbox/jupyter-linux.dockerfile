

# build:
# docker build --platform=linux/amd64 -t kaspermunch/jupyter-linux-amd64:latest .

# run interactive:
# docker run --rm -it --entrypoint /bin/bash kaspermunch/jupyter-linux-amd64:latest

# run with jupyterlab
# docker run --rm -v $(pwd):$(pwd) -w $(pwd) -i -t -p 8888:8888 kaspermunch/jupyter-linux-amd64:latest

ARG UBUNTU_VER=23.10
ARG CONDA_VER=latest
ARG OS_TYPE=x86_64
ARG PY_VER=3.8

FROM ubuntu:${UBUNTU_VER}

LABEL maintainer="Kasper Munch <kaspermunch@birc.au.dk>"

# send stdout and stderr straight to terminal
ENV PYTHONUNBUFFERED 1

# yse the above args during building 
# https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact
ARG CONDA_VER
ARG OS_TYPE
# Install miniconda to /miniconda
RUN curl -LO "http://repo.continuum.io/miniconda/Miniconda3-${PY_VERSION}_${CONDA_VERSION}-2-Linux-x86_64.sh" \
    && bash Miniconda3-${PY_VERSION}_${CONDA_VERSION}-2-Linux-x86_64.sh -p /miniconda -b \
    && rm Miniconda3-${PY_VERSION}_${CONDA_VERSION}-2-Linux-x86_64.sh
ENV PATH=/miniconda/bin:${PATH}



# RUN conda update -y conda
# ARG PY_VER
# # downgrade python if nesscary 
# RUN conda install -c anaconda -y python=${PY_VER} 
# # install packages
# RUN conda install -c bioconda -c conda-forge -c maximinio -c r -q -y \
#     git jupyterlab ipywidgets rpy2 r-essentials r-cowplot \
#     bowtie2 macs3 samtools bioconductor-chipseeker \
#     bioconductor-txdb.hsapiens.ucsc.hg38.knowngene zip ncurses
    
# ENTRYPOINT ["jupyter", "lab", "--ip='*'", "--port=8888", "--no-browser", "--allow-root"]
# #CMD []



####################################################
# update conda and create an environment with the packages we need
RUN conda update -y conda
# 
ARG PY_VER
RUN conda create -n myenv -c conda-forge -c bioconda -c r -y --freeze-installed \
    python=${PY_VER} \
    git zip jupyterlab seaborn biopython scipy statsmodels ipywidgets rpy2 r-essentials r-cowplot r-cairo \
    bowtie2 bioconductor-chipseeker bioconductor-txdb.hsapiens.ucsc.hg38.knowngene maximinio::macs3 \
    samtools ncurses    
# make RUN commands use the new environment:
SHELL ["conda", "run", "--no-capture-output", "-n", "myenv", "/bin/bash", "-c"]
RUN conda env export > environment.yml

#     run with: docker run --rm -it --entrypoint /bin/bash kaspermunch/jupyter-linux-amd64:latest
#     and while it is open do this outside container from another shell: docker cp <containerid>:/environment.yml .
#     comment out above and remove use code below instead:

# COPY environment.yml environment.yml
# RUN conda env create -q -f environment.yml && conda clean -y -i -l -t -p
# # RUN source activate myenv
# ENV PATH /opt/conda/envs/sap/bin:$PATH
####################################################


# You can add "--terminado_settings", "shell_command=/bin/bash" to ENTRYPOINT list. 
# It does not work yet but will soon (only available for jupyter collaorators):

ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "myenv", "jupyter", "lab", "--ip='*'", "--port=8888", "--no-browser", "--allow-root"]

#CMD []



