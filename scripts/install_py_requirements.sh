#!/bin/bash

# Locate the requirements.txt file relative to the script's directory
REQUIREMENTS_FILE="$(dirname "$0")/../requirements.txt"

# Check for the existence of the requirements.txt file before proceeding
if [ ! -f "$REQUIREMENTS_FILE" ]; then
    echo "requirements.txt file not found. Exiting."
    exit 1
fi

# Update Conda to ensure the latest version is being used for package management
echo "Updating Conda..."
conda update -n tf-wsl -c defaults conda -y

# Retrieve a list of all packages currently installed in the environment to avoid reinstallation
echo "Gathering list of already installed packages..."
INSTALLED_PACKAGES=$(conda list --export)

# Read each line in the requirements.txt and determine if the package needs to be installed
echo "Checking and installing packages from requirements.txt..."
while IFS= read -r PACKAGE || [[ -n "$PACKAGE" ]]; do
    # Extract just the package name from each line
    PACKAGE_NAME=$(echo "$PACKAGE" | cut -d= -f1)

    # Check if the package is already installed by searching for it in the list of installed packages
    if echo "$INSTALLED_PACKAGES" | grep -q "^$PACKAGE_NAME="; then
        echo "$PACKAGE is already installed."
    else
        echo "$PACKAGE is not installed. Installing..."
        # Install the package if it is not found in the list of installed packages
        conda install "$PACKAGE" -y
    fi
done < "$REQUIREMENTS_FILE"
