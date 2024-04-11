@echo off
echo bash script execution elevation
wsl chmod +x "/mnt/c/Users/malol/Desktop/jupyterlab_with_GPU/scripts/wsl_process.sh"
wsl chmod +x "/mnt/c/Users/malol/Desktop/jupyterlab_with_GPU/scripts/wsl_browser.sh"
echo WSL startup and bash script execution
wsl bash "/mnt/c/Users/malol/Desktop/jupyterlab_with_GPU/scripts/wsl_process.sh"
if %errorlevel% neq 0 echo Error during bash script execution
pause
