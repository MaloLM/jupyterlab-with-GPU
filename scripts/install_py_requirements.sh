#!/bin/bash

# Reading package names from requirements.txt
REQUIREMENTS_FILE="$(dirname "$0")/requirements.txt"

echo "$REQUIREMENTS_FILE"

if [ ! -f "$REQUIREMENTS_FILE" ]; then
    echo "requirements.txt file not found. Exiting."
    exit 1
fi

# Updating conda itself
conda update -n tf-wsl -c defaults conda -y

# Get a list of installed packages
INSTALLED_PACKAGES=$(conda list --export)

# Install packages from requirements.txt
while IFS= read -r PACKAGE || [[ -n "$PACKAGE" ]]; do
    PACKAGE_NAME=$(echo "$PACKAGE" | cut -d= -f1)
    if echo "$INSTALLED_PACKAGES" | grep -q "^$PACKAGE_NAME="; then
        echo "$PACKAGE is already installed."
    else
        echo "$PACKAGE is not installed. Installing..."
        conda install "$PACKAGE" -y
    fi
done < "$REQUIREMENTS_FILE"
