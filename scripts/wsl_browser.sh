#!/bin/bash

echo "Input URL: $1" >> /mnt/c/Users/malol/Desktop/wsl_browser_log.txt

# Use the original Linux path for Unix/Linux commands
linux_path=$(echo $1 | sed 's|file://||')

echo "linux_path URL: $linux_path" >> /mnt/c/Users/malol/Desktop/wsl_browser_log.txt

# Ensure the path is correctly formatted for WSL/Unix use
linux_path="/home${linux_path#/home}"

echo "linux_path URL: $linux_path" >> /mnt/c/Users/malol/Desktop/wsl_browser_log.txt

# Extract the URL and modify it
if [[ -f "$linux_path" ]]; then
    html_content=$(cat "$linux_path")

    windows_hostname=$(cmd.exe /c hostname | tr -d '\r')

    echo "html_content URL: $html_content" >> /mnt/c/Users/malol/Desktop/wsl_browser_log.txt

    # extracted_url=$(echo "$html_content" | grep -oP 'http://TUFMALO:8888[^"]+' | sed 's/TUFMALO/localhost/')
    extracted_url=$(echo "$html_content" | grep -oP "http://${windows_hostname}:8888[^"]+" | sed "s/${windows_hostname}/localhost/")

    
    echo "Extracted URL: $extracted_url" >> /mnt/c/Users/malol/Desktop/wsl_browser_log.txt

    if [[ ! -z "$extracted_url" ]]; then
        echo "openning URL: $extracted_url" >> /mnt/c/Users/malol/Desktop/wsl_browser_log.txt
        # Use cmd.exe to open the modified URL in the default web browser
        /mnt/c/Windows/System32/cmd.exe /c start "" "$extracted_url"
    else
        echo "No URL extracted." >> /mnt/c/Users/malol/Desktop/wsl_browser_log.txt
    fi
else
    echo "HTML file not found: $linux_path" >> /mnt/c/Users/malol/Desktop/wsl_browser_log.txt
fi
