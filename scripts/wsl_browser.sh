#!/bin/bash

# Remove the 'file://' prefix from the first command-line argument to normalize it to a Unix/Linux path
linux_path=$(echo $1 | sed 's|file://||')

# Ensure the path is correctly formatted for use in WSL by adjusting the path to begin explicitly from /home
linux_path="/home${linux_path#/home}"

# Check if the file exists at the specified path
if [[ -f "$linux_path" ]]; then
    # Read the content of the HTML file at the linux_path
    html_content=$(cat "$linux_path")

    # Retrieve the hostname of the Windows system, removing any carriage return characters
    windows_hostname=$(cmd.exe /c hostname | tr -d '\r')

    # Extract the JupyterLab URL from the HTML content, converting any Windows hostname to 'localhost'
    extracted_url=$(echo "$html_content" | grep -oP "http://${windows_hostname}:8888[^"]+" | sed "s/${windows_hostname}/localhost/")

    # If a URL is successfully extracted, use cmd.exe to open it in the default web browser on Windows
    if [[ ! -z "$extracted_url" ]]; then
        /mnt/c/Windows/System32/cmd.exe /c start "" "$extracted_url"
    fi
else
    # Log an error message if the HTML file cannot be found at the specified path
    echo "HTML file not found: $linux_path"
fi
