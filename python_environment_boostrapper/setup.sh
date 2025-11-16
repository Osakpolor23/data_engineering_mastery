#!/bin/bash
# This script sets up the development environment
set -eu

# Message Color Definitions
INFO='\033[0;1;34m'
ERROR='\033[0;1;31m'
SUCCESS='\033[0;1;32m'
WARNING='\033[0;1;33m'
RESET='\033[0m'

echo -e "${INFO}$(date): Starting setup process...${RESET}" | tee -a setup.log

function check_venv() {
echo -e "${INFO}Checking for existing Python virtual environment...${RESET}"
if [ -d "./.venv" ]
then
    echo -e "${WARNING}Python virtual environment already exists.${RESET}"
else
    echo -e "${ERROR}Python virtual environment not found. Creating one...${RESET}"
    python -m venv .venv
    echo -e "${SUCCESS}$(date): Virtual environment created in .venv directory.${RESET}" | tee -a setup.log
fi
echo -e "${INFO}Proceeding to activate virtual environment...${RESET}"
if [ -f "./.venv/Scripts/activate" ] # Windows
then
    source ./.venv/Scripts/activate
elif [ -f "./.venv/bin/activate" ] # Unix/Linux/Mac
then
    source ./.venv/bin/activate
else
    echo -e "${ERROR}Activation script not found in the virtual environment.${RESET}" | tee -a setup.log
    exit 1
fi

echo -e "${SUCCESS}$(date): Virtual environment activated and confirmed as $(which python)${RESET}" | tee -a setup.log
}

function pip_upgrade() {
echo -e "${INFO}Upgrading to the latest version of pip in the virtual environment${RESET}"
python -m pip install --upgrade pip
echo -e "${SUCCESS}$(date): pip upgraded to the latest version $(python -m pip --version)${RESET}" | tee -a setup.log
}

function check_gitignore() {
echo -e "${INFO}Checking for .gitignore file...${RESET}"
if [ -f ".gitignore" ] 
then
    echo -e "${WARNING}.gitignore file already exists.${RESET}"
else
    echo -e "${ERROR}.gitignore file not found.${RESET}"
    echo -e "${INFO}Creating .gitignore file...${RESET}"
    touch ./.gitignore
    echo -e "${SUCCESS}$(date): .gitignore file created.${RESET}" | tee -a setup.log
    echo -e "${INFO}Adding .venv/ and other standard ignoreables to .gitignore...${RESET}"
    echo ".venv/" >> ./.gitignore
    echo "*.env" >> ./.gitignore
    echo "__pycache__/" >> ./.gitignore
    echo -e "${SUCCESS}$(date): .venv/ and other standard ignoreables added to .gitignore.${RESET}" | tee -a setup.log
fi
}

function package_install() {
    echo -e "${INFO}Checking for requirements.txt file...${RESET}"
    if [ -f "requirements.txt" ]
    then
        echo -e "${WARNING}requirements.txt file already exists. Skipping package installation.${RESET}"
        return
    fi
    echo -e "${ERROR}requirements.txt file not found.${RESET}"
    echo -e "${INFO}Creating a requirements.txt file...${RESET}"
    touch requirements.txt
    echo -e "${SUCCESS}$(date): requirements.txt file created.${RESET}" | tee -a setup.log
    echo -e "${INFO}Writing essential packages to requirements.txt...${RESET}"
    echo "numpy" >> requirements.txt
    echo "pandas" >> requirements.txt
    echo "requests" >> requirements.txt
    echo "python-dotenv" >> requirements.txt
    echo "pytest" >> requirements.txt
    echo -e "${INFO}Installing packages from requirements.txt...${RESET}"
    python -m pip install -r requirements.txt
    echo -e "${SUCCESS}$(date): Essential packages installed from requirements.txt.${RESET}" | tee -a setup.log
}

function main() {
check_venv
pip_upgrade
check_gitignore
package_install
}

main
echo -e "${SUCCESS}$(date): Setup completed successfully.${RESET}" | tee -a setup.log




