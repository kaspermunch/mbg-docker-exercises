

FROM kaspermunch/alpine-conda:latest

# RUN /opt/conda/bin/conda install --yes --freeze-installed \
RUN /opt/conda/bin/conda install --yes \
    -c conda-forge -c bioconda -c r -y \
    python=3.8 \
    git zip jupyterlab rpy2 r-essentials r-cairo \
    bowtie2 bioconductor-chipseeker bioconductor-txdb.hsapiens.ucsc.hg38.knowngene maximinio::macs3 \
    samtools ncurses \
    && /opt/conda/bin/conda clean -afy 
    # \
    # && find /opt/conda/ -follow -type f -name '*.a' -delete \
    # && find /opt/conda/ -follow -type f -name '*.pyc' -delete \
    # && find /opt/conda/ -follow -type f -name '*.js.map' -delete \
    # && find /opt/conda/lib/python*/site-packages/bokeh/server/static -follow -type f -name '*.js' ! -name '*.min.js' -delete

ENTRYPOINT ["jupyter", "lab", "--ip='*'", "--port=8888", "--no-browser", "--allow-root"]
