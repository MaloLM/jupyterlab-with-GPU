@echo off
echo bash script execution elevation
wsl chmod +x /mnt/c/Users/malol/Desktop/start_jupyter.sh
echo WSL startup and bash script execution
wsl bash /mnt/c/Users/malol/Desktop/start_jupyter.sh
if %errorlevel% neq 0 echo Error during bash script execution
pause
