@echo off
echo --- Bash script execution elevation

:: Get the full path of the current directory without the trailing backslash
set WSL_SCRIPT_PATH=%~dp0
set WSL_SCRIPT_PATH=%WSL_SCRIPT_PATH:\=/%
set WSL_SCRIPT_PATH=%WSL_SCRIPT_PATH:~0,-1%

:: Convert Windows path to WSL path with lowercase drive letter
:: Extract the drive letter, convert it to lowercase, and format it for WSL
set DRIVE_LETTER=%WSL_SCRIPT_PATH:~0,1%
set DRIVE_LETTER=%DRIVE_LETTER:~0,1%
for %%i in ("A=a" "B=b" "C=c" "D=d" "E=e" "F=f" "G=g" "H=h" "I=i" "J=j" "K=k" "L=l" "M=m" "N=n" "O=o" "P=p" "Q=q" "R=r" "S=s" "T=t" "U=u" "V=v" "W=w" "X=x" "Y=y" "Z=z") do (
    call set DRIVE_LETTER=%%DRIVE_LETTER:%%~i%%
)
set WSL_SCRIPT_PATH=/mnt/%DRIVE_LETTER%/%WSL_SCRIPT_PATH:~3%

:: Use chmod in WSL on correct paths
wsl chmod +x "%WSL_SCRIPT_PATH%/wsl_process.sh"
wsl chmod +x "%WSL_SCRIPT_PATH%/wsl_browser.sh"


echo --- WSL startup and bash script execution
wsl bash "%WSL_SCRIPT_PATH%/wsl_process.sh"

:: Check for errors after running the script
if %errorlevel% neq 0 echo Error during bash script execution
pause
