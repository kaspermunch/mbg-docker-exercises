
ARG OS_TYPE=x86_64

# python 3.7
# ARG MINIOCONDA_IMG_VER=3.14.1 # maybe...
# python 3.8
ARG MINIOCONDA_IMG_VER=4.8.3
# python 3.9
# ARG MINIOCONDA_IMG_VER=4.12.0
# python 3.10
# ARG MINIOCONDA_IMG_VER=23.3.1-0
# python 3.11
# ARG MINIOCONDA_IMG_VER=23.10.0-1

FROM continuumio/miniconda3:$MINIOCONDA_IMG_VER

# install packages
RUN conda install -c conda-forge -q -y \
        jupyterlab nodejs anaconda-toolbox \
    && /opt/conda/bin/conda clean -afy     
  
# You can add "--terminado_settings", "shell_command=/bin/bash" to ENTRYPOINT list. 
# It does not work yet but will soon (only available for jupyter collaorators):
ENTRYPOINT ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
#CMD []