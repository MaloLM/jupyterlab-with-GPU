#!/bin/bash

# Use the original Linux path for Unix/Linux commands
linux_path=$(echo $1 | sed 's|file://||')

# Ensure the path is correctly formatted for WSL/Unix use
linux_path="/home${linux_path#/home}"

# Extract the URL and modify it
if [[ -f "$linux_path" ]]; then
    html_content=$(cat "$linux_path")

    windows_hostname=$(cmd.exe /c hostname | tr -d '\r')

    extracted_url=$(echo "$html_content" | grep -oP "http://${windows_hostname}:8888[^"]+" | sed "s/${windows_hostname}/localhost/")

    if [[ ! -z "$extracted_url" ]]; then
        # Use cmd.exe to open the modified URL in the default web browser
        /mnt/c/Windows/System32/cmd.exe /c start "" "$extracted_url"
    
else
    echo "HTML file not found: $linux_path"
fi
