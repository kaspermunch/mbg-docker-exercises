

FROM frolvlad/alpine-glibc:alpine-3.9_glibc-2.29
LABEL MAINTAINER="Kasper Munch"

ENV CONDA_VERSION 23.11.0
ENV PY_VERSION py38

#Miniconda3-py38_23.11.0-2-Linux-x86_64.sh
#Miniconda3-${PY_VERSION}_${CONDA_VERSION}-Linux-x86_64.sh

# Tell Python not to recreate the bytecode files. Since this is a docker image,
# these will be recreated every time, writing them just uses unnecessary disk
# space.
ENV PYTHONDONTWRITEBYTECODE=true

# We do the following all in one block:
# - Create user and group anaconda
# - Install miniconda install dependencies
# - Download miniconda and check the md5sum
# - Install miniconda
# - Downgrade and pin conda to 4.6.8 (can remove once 4.7 is released)
# - Install tinid
# - Remove all conda managed static libraries
# - Remove all conda managed *.pyc files
# - Cleanup conda files
# - Uninstall miniconda install dependencies
RUN apk add --no-cache wget bzip2 \
    && addgroup -S anaconda \
    && adduser -D -u 10151 anaconda -G anaconda \
    && wget --quiet https://repo.continuum.io/miniconda/Miniconda3-${PY_VERSION}_${CONDA_VERSION}-2-Linux-x86_64.sh \
    && mv Miniconda3-${PY_VERSION}_${CONDA_VERSION}-2-Linux-x86_64.sh miniconda.sh \
    && sh ./miniconda.sh -b -p /opt/conda \
    && ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh \
    && echo ". /opt/conda/etc/profile.d/conda.sh" >> /home/anaconda/.profile \
    && echo "conda activate base" >> /home/anaconda/.profile \
    && /opt/conda/bin/conda install conda==$CONDA_VERSION  \
    && echo "conda ==$CONDA_VERSION " >> /opt/conda/conda-meta/pinned \
    && /opt/conda/bin/conda install --freeze-installed tini -y \
    && find /opt/conda/ -follow -type f -name '*.a' -delete \
    && find /opt/conda/ -follow -type f -name '*.pyc' -delete \
    && /opt/conda/bin/conda clean -afy \
    && chown -R anaconda:anaconda /opt/conda \
    && apk del wget bzip2

USER anaconda:anaconda
WORKDIR /home/anaconda/

COPY start.sh /usr/local/bin/

ENTRYPOINT ["/opt/conda/bin/tini", "-g", "--", "/usr/local/bin/start.sh"]
CMD ["sh", "--login", "-i"]