# Setup

# Table of Contents

- [NVIDIA Driver Installation](#nvidia-driver-installation)
- [WSL2 Environment Setup](#wsl2-environment-setup)
- [Miniconda Setup](#miniconda-setup)
- [Setting Up Your Conda Virtual Environment](#setting-up-your-conda-virtual-environment)
- [CUDA Setup](#cuda-setup)
- [Installing TensorFlow](#installing-tensorflow)
- [Script Setup](#script-setup)
- [Troubleshooting](#troubleshooting)

## NVIDIA Driver installation

Download and install the [Windows NVIDIA driver](https://www.nvidia.fr/Download/index.aspx?lang%3Dfr)

After installing the Nvidia driver, restarting the windows machine is not too much required.

## WSL2 environment setup

There are many ways to install WSL. You can find tutorials on the web in case next approach is not working for you:

First open a PowerShell terminal and type following command:
``` bash
wsl --install
```
Above command will install Ubuntu by default. This tutorial assumes that you are using WSL with Ubuntu but you are free to use any other available Linux distribution.

## Miniconda Setup

### Step 1: Download Miniconda3
Open your WSL terminal and execute the following command to download the Miniconda3 installation script:

```bash
curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
```

### Step 2: Run the Installation Script
Execute the script to start the Miniconda3 installation process:

```bash
bash Miniconda3-latest-Linux-x86_64.sh
```

### Step 3: Accept the License Terms
During the installation process, you'll be prompted to review and accept the license terms. Scroll through the license and type `yes` to agree.

### Step 4: Initialization
Upon being prompted "Do you wish the installer to initialize Miniconda3 by running conda init?", type `yes`. This step ensures that the Conda base environment is properly initialized within WSL, enabling seamless management of your Python environments and packages.

Follow the on-screen instructions to complete the installation. After installation, close and reopen your WSL terminal to activate the Conda environment.

By following these steps, you will have successfully set up Miniconda3 in WSL, laying a solid foundation for your machine learning projects.

## Setting Up Your Conda Virtual Environment

### Creating the Environment

To establish a new Conda environment specifically for your project, open your terminal and execute the following command:

```bash
conda create --name tf-wsl python=3.9
```

This command creates a new virtual environment named `tf-wsl` with Python 3.9 installed. The environment name `tf-wsl` is chosen to reflect the TensorFlow projects you'll be running within the Windows Subsystem for Linux (WSL).

Upon completion, activate your newly created environment using:

```bash
conda activate tf-wsl
```

### Updating Your WSL `.bashrc` for Automatic Environment Activation

To enhance your workflow and automate the activation of the TensorFlow GPU acceleration environment (`tf-wsl`) whenever a Jupyter server is running, you can add a snippet of code to the `.bashrc` file of your WSL user profile. This setup ensures that the Conda environment is activated automatically under specific conditions, simplifying your development process. Follow the steps below to update your `.bashrc`:

1. **Open the `.bashrc` File**:
   - Open your WSL terminal.
   - Type the following command to edit your `.bashrc` file in your preferred text editor (e.g., `nano` or `vi`):
     ```
     nano ~/.bashrc
     ```

2. **Add the Conditional Activation Code**:
   - Scroll to the end of the `.bashrc` file.
   - Add the following lines to automatically activate the `tf-wsl` environment when the `JUPYTER_SERVER_URL` environment variable is set (which typically happens when a Jupyter server is started):
     ```bash
     if [ -n "$JUPYTER_SERVER_URL" ]; then
         source ~/miniconda3/etc/profile.d/conda.sh
         conda activate tf-wsl
     fi
     ```
   - This script checks if the `JUPYTER_SERVER_URL` variable is set, indicating that a Jupyter server is active. If it is, the script sources the Conda configuration script and activates the specified Conda environment.

3. **Save and Exit**:
   - Save the changes to the `.bashrc` file.
     - For `nano`, press `Ctrl+O`, `Enter` to save, and `Ctrl+X` to exit.
     - For `vi`, press `Esc`, type `:wq`, and press `Enter` to save and exit.
   - Close the terminal.

## CUDA setup

### Verifying Your CUDA Version

Open your terminal and execute the following command to check the CUDA version installed on your system:

```bash
nvidia-smi
```

This command displays various details about your NVIDIA GPU, including the currently installed CUDA version, depicted in a tabular format.

    Important Compatibility Note (As of April 2024): TensorFlow requires CUDA version 11 for GPU acceleration. If the table indicates CUDA version 12.0, you will need to install a compatible version of CUDA to use TensorFlow with GPU support.

### Installing the Compatible CUDA Toolkit in Your Conda Environment

Should your system have CUDA 12.0 installed, follow these steps to install CUDA Toolkit V11.2.2 and cuDNN V8.1.0 within your tf-wsl Conda environment, ensuring compatibility with TensorFlow:

#### Activate your custom Conda environment:

```bash
conda activate tf-wsl
```

#### Install the CUDA Toolkit V11 and cuDNN V8 by executing:

```bash
conda install -c conda-forge cudatoolkit=11.2.2 cudnn=8.1.0
```

This command installs the specific versions of CUDA Toolkit and cuDNN required for TensorFlow GPU acceleration within your tf-wsl environment, ensuring that your development environment is both optimized and compatible with TensorFlow's current requirements.

### Configuring the CUDA 11 Path for TensorFlow Compatibility

For TensorFlow to utilize GPU acceleration effectively, it's crucial to ensure that it can locate and use the CUDA 11 libraries installed in your Conda environment. This involves specifying the CUDA library path in your environment variables.

Follow these steps to configure the CUDA 11 path correctly:

#### Creating the Activation Script Directory

First, you need to create a directory for Conda activation scripts if it doesn't already exist. These scripts run automatically whenever you activate your Conda environment. Open your terminal and run:

```bash
mkdir -p $CONDA_PREFIX/etc/conda/activate.d
```

This command safely creates the directory, avoiding duplication if it already exists (`-p` option).

#### Setting the CUDA Library Path

Next, you'll create a script that sets the `LD_LIBRARY_PATH` environment variable to include your Conda environment's `lib` directory. This ensures that TensorFlow can access the CUDA 11 libraries upon activation of your environment.

Execute the following command:

```bash
echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/' > $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh
```

This command writes a new script `env_vars.sh` in the `activate.d` directory. The script appends the path to your Conda environment's `lib` directory to the existing `LD_LIBRARY_PATH`. This modification is essential for enabling TensorFlow to locate and use the CUDA 11 libraries correctly.

## Installing TensorFlow

For optimal performance and access to the latest features, TensorFlow should be installed directly using `pip`, rather than through Conda. This approach ensures you're working with the most recent stable release of TensorFlow. Follow the steps below to install TensorFlow and verify GPU support.

### Step 1: Upgrade `pip`

Ensure that your `pip` installer is up-to-date to avoid any installation issues. In your activated Conda environment, run:

```bash
pip install --upgrade pip
```

### Step 2: Install TensorFlow

Install a specific version of TensorFlow, such as 2.11, to ensure compatibility with your projects. Use the following command:

```bash
pip install tensorflow==2.11.*
```

This command installs TensorFlow version 2.11, ensuring you have the latest patches within that series.

### Step 3: Verify TensorFlow GPU Support

After installation, it's crucial to verify that TensorFlow can recognize and utilize your GPU. Run the following command:

```bash
python3 -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"
```

The output will include various warnings (which are normal) and should list the GPUs available to TensorFlow. An empty list indicates an issue with recognizing the GPU, suggesting a need for troubleshooting.

### Detailed GPU Verification

For a more detailed assessment of TensorFlow's GPU utilization, execute the following Python script:

```python
import tensorflow as tf

print("TensorFlow version:", tf.__version__)
print("Num GPUs Available: ", len(tf.config.list_physical_devices('GPU')))

if tf.config.list_physical_devices('GPU'):
    devices = tf.config.list_physical_devices('GPU')
    for device in devices:
        print("Name:", device.name, "Type:", device.device_type)
        details = tf.config.experimental.get_device_details(device)
        print("Device Name:", details['device_name'])
else:
    print("No GPU available.")
```

This script provides a comprehensive overview of TensorFlow's version, the number of GPUs available, and detailed information about each GPU detected. If no GPU is available, the script will indicate so, pointing towards the need for further configuration or troubleshooting steps.

Certainly! Here's a cleaner and more streamlined version of the instructions for setting up the script:

## Script Setup

Follow these steps to set up the `LaunchJupyterWSL.bat` script for starting JupyterLab with TensorFlow GPU acceleration:

1. **Clone the Repository**: Clone or download the repository to your desired location on your system.

2. **Create a Shortcut**:
   - Navigate to the `scripts/LaunchJupyterWSL.bat` file within the repository.
   - Right-click on the file and select **Create shortcut**. (On Windows 11, you may have to select show more options to see the "create shortcut")
   - Move the shortcut to a convenient location for easy access.

3. **Launch JupyterLab**:
   - Double-click the shortcut to start JupyterLab.
   - This will activate the TensorFlow GPU acceleration environment automatically.

## Troubleshooting

**If JupyterLab does not open automatically in your web browser:**
    - Try navigating to `http://localhost:8888` in your browser.
    - If that doesn't work, check the server logs in the opened terminal for any error messages or the server URL, and then copy and paste it into your browser.
