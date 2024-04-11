#!/bin/bash

echo "--- Loading conda source"
source ~/miniconda3/etc/profile.d/conda.sh || { echo "Error while loading conda.sh"; exit 1; }

echo "--- Conda env startup"
conda activate tf-wsl || { echo "Error while starting conda env up"; exit 1; }

script_dir=$(dirname "$0")
requirements_script="install_py_requirements.sh"
"$script_dir/$requirements_script"

echo "--- Jupyter Lab startup"
jupyter lab --notebook-dir="~/notebooks/" --ip=0.0.0.0 || { echo "Error while starting Jupyterlab"; exit 1; }