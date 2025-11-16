# PYTHON ENVIRONMENT BOOTSTRAPPER

## OVERVIEW

Developers and data engineers often spend a significant amount of time setting up their Python development environments for new projects. This process which typically includes creating virtual environments, installing necessary packages, and configuring project files often needs to be repeated for each new project, thereby consuming valuable time and effort. This bash scripts aims to streamline and automate the setup of Python development environments by creating virtual environments if they do not exist and activating them once created(or if they already exists), upgrading pip to the latest version, and generating essential project files like `.gitignore` and `requirements.txt`. It also installs some of the most commonly used Python packages to kickstart development while outputting logs of all actions taken during the setup process to the terminal and a log file named `setup.log` in interactive colors for better readability, clarity, tracking and user experience. In this case, Color Blue for general information, Green for success messages, Yellow for warnings, and Red for errors.

## FEATURES
- **Virtual Environment Management**: Automatically detects existing virtual environments or creates a new one if none are found.
- **Pip Upgrade**: Ensures that the latest version of pip is installed in the virtual environment.
- **Project File Generation**: Creates a `.gitignore` file(if it doesn't exist) with standard ignore patterns and a `requirements.txt` file for package management.
- **Package Installation**: Installs a predefined list of commonly used Python packages to get developers started quickly.
- **Logging**: Outputs all actions to both the terminal and a log file (`setup.log`) with color-coded messages for better readability.

## USAGE
To use the Python Environment Bootstrapper script, follow these steps:
1. **Clone the Repository**: Clone the repository containing the `setup.sh` script to your local machine.
    ```bash
    git clone https://github.com/Osakpolor23/data_engineering_mastery.git
    ``` 
2. **Navigate to the Script Directory**: Change your directory to where the `setup.sh` script is located.
    ```bash
    cd python_environment_boostrapper
    ```
3. **Run the Script**: Execute the script with `source setup.sh` in your gitbash terminal. Make sure you have the necessary permissions to run the script.
If you run the script without sourcing it, the virtual environment will not be activated in your current terminal session after the script completes.

    ```bash
    source setup.sh
    ```

## EXAMPLE RUN AND OUTPUT(DEMO)
At first run, the script will create a virtual environment(if none exists), upgrade pip, generate project files, and install the specified packages. On subsequent runs, it will activate the existing virtual environment and ensure everything is up to date.

**First Time Setup Example Run and Output:**

```bash 
   $ source setup.sh
```
**Output:**
Below is an example of the output you might see when running the script for the first time:
```
Sun, Nov 16, 2025  5:55:13 PM: Starting setup process...
Checking for existing Python virtual environment...
Python virtual environment not found. Creating one...
Sun, Nov 16, 2025  5:55:54 PM: Virtual environment created in .venv directory.
Sun, Nov 16, 2025  5:55:54 PM: Virtual environment activated and confirmed as /c/Users/HP/python_environment_bootstrapper/python_environment_boostrapper/.venv/Scripts/python
Upgrading to the latest version of pip in the virtual environment
(followed by pip upgrade outputs and success message)
Sun, Nov 16, 2025  5:56:35 PM: pip upgraded to the latest version pip 25.3 from C:\Users\HP\python_environment_bootstrapper\python_environment_boostrapper\.venv\Lib\site-packages\pip (python 3.12)
Checking for .gitignore file...
.gitignore file not found.
Sun, Nov 16, 2025  5:56:36 PM: .gitignore file created.
Sun, Nov 16, 2025  5:56:36 PM: .gitignore file created.
Adding .venv/ and other standard ignoreables to .gitignore...
Checking for requirements.txt file...
requirements.txt file not found.
Creating a requirements.txt file...
Sun, Nov 16, 2025  5:56:37 PM: requirements.txt file created.
Writing essential packages to requirements.txt...
Installing packages from requirements.txt...
(followed by package installation outputs and success message)
Sun, Nov 16, 2025  6:00:57 PM: Essential packages installed from requirements.txt.
Sun, Nov 16, 2025  6:00:58 PM: Setup completed successfully.
```
**Subsequent Run Example Output:**

```bash 
   $ source setup.sh
``` 

**Output:**
Below is an example of the output you might see when running the script subsequently:
```
Sun, Nov 16, 2025  6:04:19 PM: Starting setup process...
Checking for existing Python virtual environment...
Python virtual environment already exists.
Proceeding to activate virtual environment...
Sun, Nov 16, 2025  6:04:19 PM: Virtual environment activated and confirmed as /c/Users/HP/python_environment_bootstrapper/python_environment_boostrapper/.venv/Scripts/python
Upgrading to the latest version of pip in the virtual environment
Requirement already satisfied: pip in c:\users\hp\python_environment_bootstrapper\python_environment_boostrapper\.venv\lib\site-packages (25.3)
Sun, Nov 16, 2025  6:04:26 PM: pip upgraded to the latest version pip 25.3 from C:\Users\HP\python_environment_bootstrapper\python_environment_boostrapper\.venv\Lib\site-packages\pip (python 3.12)
Checking for .gitignore file...
.gitignore file already exists.
Checking for requirements.txt file...
requirements.txt file already exists. Skipping package installation.
Sun, Nov 16, 2025  6:04:28 PM: Setup completed successfully.
```

## BENEFITS
- **Time-Saving**: Reduces the time spent on setting up Python development environments for new projects.
- **Consistency**: Ensures that all projects start with a consistent environment and configuration.
- **Ease of Use**: Simplifies the setup process with a single script, making it accessible even for those with limited experience in environment management.
- **Improved Tracking**: The logging feature allows developers to track the setup process and troubleshoot any issues that may arise.


## THINGS LEARNT AND CHALLENGES FACED
1. The concept of subshells: when a bash script is executed using `bash script.sh` vs `source script.sh`. When executed normally, the script runs in a subshell, and any environment changes (like activating a virtual environment) only affects the subshell and do not affect the parent shell. Sourcing the script such as using `source script.sh` or `. script.sh` runs it in the current shell, allowing changes to persist. I initially had an issue while trying to just run the script normally which led to the virtual environment not being activated in my current terminal session after the script completed. Sourcing the script resolved this issue.

2. which python: This command shows the path of the Python interpreter that would be executed in the current environment. It can be very useful to verify which Python version is being used, especially when working with virtual environments. This was used in my script to confirm that the virtual environment was activated successfully by checking the path of the Python interpreter after activation which pointed to the virtual environment's Python executable.
This can be found on the line:

```bash
    echo -e "${GREEN}Virtual environment activated and confirmed as $(which python)${RESET}" | tee -a setup.log
```

3. Finding virtual environments using a combination of ls -la and grep -E -i -q with regex patterns to identify common virtual environment directory names like .venv, venv etc. Although this method can help locate virtual environments, it may not be foolproof as naming conventions can vary and it wasn't used in the final solution anymore. The approach I opted for initially was this:
```bash
    if ls -la 2>/dev/null | grep -E -i -q "^d.*(\.)?venv"; then ...
```
This was because I observed and believed that most virtual environments were named with names like myvenv,venv etc outside of just .venv. However, I later opted to just check for the presence of a .venv directory only for simplicity.

4. The use of tee -a command to append the output of commands to a log file while also displaying it on the terminal. This is useful for keeping a record of actions taken during script execution. e.g., echo "message" | tee -a setup.log.
This was used extensively throughout the script to log messages and also display them in the terminal for the user to see.

## CONCLUSION
The Python Environment Bootstrapper script is a valuable tool for developers looking to streamline the setup of their Python development environments.

