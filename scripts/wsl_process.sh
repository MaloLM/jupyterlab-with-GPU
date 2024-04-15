#!/bin/bash

# Load the Conda environment configurations
echo "--- Loading conda source"
source ~/miniconda3/etc/profile.d/conda.sh || { echo "Error while loading conda.sh"; exit 1; }

# Activate the specific Conda environment
echo "--- Conda env startup"
conda activate tf-wsl || { echo "Error while starting conda env up"; exit 1; }

# Determine the directory of the current script to locate other scripts correctly
script_dir=$(dirname "$0")

# Define the path to the requirements installation script
requirements_script="install_py_requirements.sh"

# Execute the requirements installation script
"$script_dir/$requirements_script"

# Define the directory where notebooks will be stored
notebook_dir=~/notebooks

# Check if the notebook directory exists; create it if it does not
if [ ! -d "$notebook_dir" ]; then
    echo "--- Creating notebooks directory"
    mkdir -p "$notebook_dir"
fi

# Start Jupyter Lab pointing to the defined notebook directory and allowing connections
echo "--- Jupyter Lab startup"
jupyter lab --notebook-dir="$notebook_dir" --ip=0.0.0.0 || { echo "Error while starting Jupyterlab"; exit 1; }
