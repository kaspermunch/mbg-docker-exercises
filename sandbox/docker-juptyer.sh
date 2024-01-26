

conda create -n myenv -c bioconda -c conda-forge -q -y macs2 bowtie2 samtools bioconductor-chipseeker bioconductor-txdb.hsapiens.ucsc.hg38.knowngene &>/dev/null

!sudo apt -y install bowtie2 &> /dev/null

!pip install macs3 &> /dev/null

!sudo apt-get -qq install -y samtools &> /dev/null

!wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -q
!bash Miniconda3-latest-Linux-x86_64.sh -b -p /content/miniconda &> /dev/null
!rm /content/Miniconda3-latest-Linux-x86_64.sh
!/content/miniconda/bin/conda config --add channels bioconda
!/content/miniconda/bin/conda config --add channels conda-forge
!/content/miniconda/bin/conda install mamba -y &> /dev/null
print("Creating conda environment...")
!/content/miniconda/bin/conda create --name myenv -y -q &> /dev/null
print("Installing bioconductor ChIP-seq packages...")
!/content/miniconda/bin/conda install -n myenv bioconductor-chipseeker bioconductor-txdb.hsapiens.ucsc.hg38.knowngene -q -y &>/dev/null
print("Done!!")




docker run -i -t -p 8888:8888 continuumio/miniconda3 /bin/bash -c "/opt/conda/bin/conda install jupyter -y --quiet && mkdir /opt/notebooks && /opt/conda/bin/jupyter notebook --notebook-dir=/opt/notebooks --ip='*' --port=8888 --no-browser --allow-root"

docker run -v $(pwd):$(pwd) -w $(pwd) -i -t -p 8888:8888 continuumio/miniconda3 /bin/bash -c "/opt/conda/bin/conda install jupyter -y --quiet && mkdir /opt/notebooks && /opt/conda/bin/jupyter notebook --notebook-dir=/opt/notebooks --ip='*' --port=8888 --no-browser --allow-root"

docker run -v $(pwd):$(pwd) -w $(pwd) -i -t -p 8888:8888 continuumio/miniconda3 /bin/bash -c "/opt/conda/bin/conda install jupyter -y --quiet && mkdir /opt/notebooks && /opt/conda/bin/jupyter notebook --ip='*' --port=8888 --no-browser --allow-root"


docker run -v $(pwd):$(pwd) -w $(pwd) -i -t -p 8888:8888 continuumio/miniconda3 /bin/bash -c "/opt/conda/bin/conda install jupyterlab -y --quiet && mkdir /opt/notebooks && /opt/conda/bin/jupyter lab --ip='*' --port=8888 --no-browser --allow-root"

docker run -v $(pwd):$(pwd) -w $(pwd) -i -t -p 8888:8888 continuumio/miniconda3 /bin/bash -c "CONDA_SUBDIR=osx-64 /opt/conda/bin/conda create -n myenv jupyterlab -y --quiet && mkdir /opt/notebooks && source activate myenv && /opt/conda/bin/conda config --env --set subdir osx-64 && /opt/conda/envs/myenv/bin/jupyter lab --ip='*' --port=8888 --no-browser --allow-root"

docker run -v $(pwd):$(pwd) -w $(pwd) -i -t -p 8888:8888 continuumio/miniconda3 /bin/bash -c "/opt/conda/bin/conda create -n myenv jupyterlab -y --quiet && mkdir /opt/notebooks && source activate myenv && /opt/conda/envs/myenv/bin/jupyter lab --ip='*' --port=8888 --no-browser --allow-root"

docker run -v $(pwd):$(pwd) -w $(pwd) -i -t -p 8888:8888 continuumio/miniconda3 /bin/bash -c "CONDA_SUBDIR=osx-64 /opt/conda/bin/conda create -n myenv jupyterlab -y --quiet && mkdir /opt/notebooks && source activate myenv && /opt/conda/bin/conda config --env --set subdir osx-64 && /opt/conda/envs/myenv/bin/jupyter lab --ip='*' --port=8888 --no-browser --allow-root"



Skipped non-installed server(s): bash-language-server, dockerfile-language-server-nodejs, javascript-typescript-langserver, jedi-language-server, julia-language-server, pyright, python-language-server, python-lsp-server, r-languageserver, sql-language-server, texlab, typescript-language-server, unified-language-server, vscode-css-languageserver-bin, vscode-html-languageserver-bin, vscode-json-languageserver-bin, yaml-language-server




docker run -v $(pwd):$(pwd) -w $(pwd) -i -t -p 8888:8888 continuumio/miniconda3 /bin/bash -c "CONDA_SUBDIR=osx-64 /opt/conda/bin/conda create -n myenv jupyterlab -y --quiet && mkdir /opt/notebooks && /opt/conda/bin/conda config --file /opt/conda/envs/myenv/.condarc --set subdir osx-64 && /opt/conda/envs/myenv/bin/jupyter lab --ip='*' --port=8888 --no-browser --allow-root"

docker run -v $(pwd):$(pwd) -w $(pwd) -i -t -p 8888:8888 continuumio/miniconda3 /bin/bash -c "/opt/conda/bin/conda create -n myenv jupyterlab -y --quiet && mkdir /opt/notebooks && /opt/conda/bin/activate myenv && /opt/conda/envs/myenv/bin/jupyter lab --ip='*' --port=8888 --no-browser --allow-root"




docker run -v $(pwd):$(pwd) -w $(pwd) -i -t --env CONDA_SUBDIR=osx-64 -p 8888:8888 continuumio/miniconda3 /bin/bash -c "/opt/conda/bin/conda create -n myenv jupyterlab -y -q && mkdir /opt/notebooks && /opt/conda/bin/conda config --file /opt/conda/envs/myenv/.condarc --set subdir osx-64 && /opt/conda/envs/myenv/bin/jupyter lab --ip='*' --port=8888 --no-browser --allow-root"






docker run -v $(pwd):$(pwd) -w $(pwd) -i -t -p 8888:8888 --env CONDA_SUBDIR=osx-64 continuumio/miniconda3 /bin/bash -c "/opt/conda/bin/conda create -n myenv jupyterlab -y -q && /opt/conda/bin/conda config --file /opt/conda/envs/myenv/.condarc --set subdir /opt/conda/envs/myenv/osx-64 && /opt/conda/envs/myenv/bin/jupyter lab --ip='*' --port=8888 --no-browser --allow-root"
docker run -v $(pwd):$(pwd) -w $(pwd) -i -t -p 8888:8888 continuumio/miniconda3 /bin/bash -c "/opt/conda/bin/conda create -n myenv jupyterlab -y -q && /opt/conda/envs/myenv/bin/jupyter lab --ip='*' --port=8888 --no-browser --allow-root"


docker run -v $(pwd):$(pwd) -w $(pwd) -i -t -p 8888:8888 --env CONDA_SUBDIR=osx-64 continuumio/miniconda3 /bin/bash -c "/opt/conda/bin/conda create -n myenv jupyterlab -y -q && source activate myenv && /opt/conda/bin/conda config --env --set subdir osx-64 && /opt/conda/envs/myenv/bin/jupyter lab --ip='*' --port=8888 --no-browser --allow-root"
docker run -v $(pwd):$(pwd) -w $(pwd) -i -t -p 8888:8888 --env CONDA_SUBDIR=osx-64 continuumio/miniconda3 /bin/bash -c "/opt/conda/bin/conda create -n myenv jupyterlab -y -q && source activate myenv && /opt/conda/bin/conda config --env --set subdir osx-64 && jupyter lab --ip='*' --port=8888 --no-browser --allow-root"

docker run -v $(pwd):$(pwd) -w $(pwd) -i -t -p 8888:8888 continuumio/miniconda3 /bin/bash -c "/opt/conda/bin/conda create -n myenv jupyterlab -y -q && /opt/conda/envs/myenv/bin/jupyter lab --ip='*' --port=8888 --no-browser --allow-root"



# default arch in base
docker run -v $(pwd):$(pwd) -w $(pwd) -i -t -p 8888:8888 continuumio/miniconda3 /bin/bash -c "/opt/conda/bin/conda install jupyter -y --quiet && /opt/conda/bin/jupyter lab --ip='*' --port=8888 --no-browser --allow-root"

# linux/amd64 in base
docker run  --platform linux/amd64 -v $(pwd):$(pwd) -w $(pwd) -i -t -p 8888:8888 continuumio/miniconda3 /bin/bash -c "/opt/conda/bin/conda install jupyter -y --quiet && /opt/conda/bin/jupyter lab --ip='*' --port=8888 --no-browser --allow-root"


# default arch with environment
docker run -v $(pwd):$(pwd) -w $(pwd) -i -t -p 8888:8888 continuumio/miniconda3 /bin/bash -c "/opt/conda/bin/conda create -n myenv jupyterlab -y -q  && source activate myenv && jupyter lab --ip='*' --port=8888 --no-browser --allow-root"

# osx-64 environment on M1 arch
docker run -v $(pwd):$(pwd) -w $(pwd) -i -t -p 8888:8888 --env CONDA_SUBDIR=osx-64 continuumio/miniconda3 /bin/bash -c "/opt/conda/bin/conda create -n myenv jupyterlab -y -q && source activate myenv && /opt/conda/bin/conda config --env --set subdir osx-64 && jupyter lab --ip='*' --port=8888 --no-browser --allow-root"




docker run  --platform linux/amd64 -v $(pwd):$(pwd) -w $(pwd) -i -t -p 8888:8888 continuumio/miniconda3 /bin/bash -c "/opt/conda/bin/conda install -y -q \
\
-c bioconda -c conda-forge -c maximinio  jupyterlab macs3 bowtie2 samtools bioconductor-chipseeker bioconductor-txdb.hsapiens.ucsc.hg38.knowngene \
\
&& /opt/conda/bin/jupyter lab --ip='*' --port=8888 --no-browser --allow-root"





docker build --platform=linux/amd64 -t kaspermunch/jupyter-linux-amd64:latest .

docker run -it --entrypoint /bin/bash kaspermunch/jupyter-linux-amd64:latest


docker run -t -i -p 8888:8888 --rm  -v $(pwd):$(pwd) -w $(pwd) kaspermunch/jupyter-linux-amd64:latest /bin/bash -c "/opt/conda/bin/jupyter lab --ip='*' --port=8888 --no-browser --allow-root"
