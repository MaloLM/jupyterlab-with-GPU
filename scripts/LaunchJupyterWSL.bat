@echo off
echo --- Bash script execution elevation

:: Get the full path of the current directory of the batch file, removing the trailing backslash
set WSL_SCRIPT_PATH=%~dp0
set WSL_SCRIPT_PATH=%WSL_SCRIPT_PATH:\=/%
set WSL_SCRIPT_PATH=%WSL_SCRIPT_PATH:~0,-1%

:: Convert the Windows path to a WSL-compatible path by formatting the drive letter to lowercase
:: and adjusting the path format to match WSL's expected style
set DRIVE_LETTER=%WSL_SCRIPT_PATH:~0,1%
set DRIVE_LETTER=%DRIVE_LETTER:~0,1%
for %%i in ("A=a" "B=b" "C=c" "D=d" "E=e" "F=f" "G=g" "H=h" "I=i" "J=j" "K=k" "L=l" "M=m" "N=n" "O=o" "P=p" "Q=q" "R=r" "S=s" "T=t" "U=u" "V=v" "W=w" "X=x" "Y=y" "Z=z") do (
    call set DRIVE_LETTER=%%DRIVE_LETTER:%%~i%%
)
set WSL_SCRIPT_PATH=/mnt/%DRIVE_LETTER%/%WSL_SCRIPT_PATH:~3%

:: Ensure the necessary scripts are executable in WSL by setting permissions using chmod
wsl chmod +x "%WSL_SCRIPT_PATH%/wsl_process.sh"
wsl chmod +x "%WSL_SCRIPT_PATH%/wsl_browser.sh"

echo --- WSL startup and bash script execution
:: Execute the bash script in WSL
wsl bash "%WSL_SCRIPT_PATH%/wsl_process.sh"

:: Check for any errors that occurred during the execution of the bash script
if %errorlevel% neq 0 (
    echo Error during bash script execution
)
pause
