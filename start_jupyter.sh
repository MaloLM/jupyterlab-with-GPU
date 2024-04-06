#!/bin/bash
echo "--- Loading conda source"
source ~/miniconda3/etc/profile.d/conda.sh || { echo "Erreur lors de la source conda.sh"; exit 1; }
echo "--- Conda env startup"
conda activate tf-wsl || { echo "Erreur lors de l'activation de l'environnement conda"; exit 1; }
echo "--- Jupyter Lab startup"
jupyter lab --dir="~/notebooks/" --ip=0.0.0.0 || { echo "Erreur lors du démarrage de Jupyter Lab"; exit 1; }