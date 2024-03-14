
Install Docker

On Mac, do not enable "Start Docker Desktop when you sign in to your computer". It will make it choke when the computer goes to sleep.


- mbg-base: curl, git, gzip, tar
  - mbg-base-py38: python-version
    - mbg-base-jupyter-py38: mbg-base-py38, jupyterlab, nodejs, anaconda-toolbox  
        - mbg-base-jupyter-py-py38: mbg-base-jupyter-py38, seaborn, ipywidgets, jupyter_dashboards, 
        - mbg-base-jupyter-r-py38: mbg-base-jupyter-py38, r-essentials, 
        - mbg-base-jupyter-rpy-py38: mbg-base-jupyter-py38, seaborn, ipywidgets, jupyter_dashboards, r-essentials, rpy2
            - mbg-BSF-Week1
  - mbg-base-py39: 
    - ...
      - ...
        - ...
            - mbg-BSF-Week4
  - mbg-base-py310: 

