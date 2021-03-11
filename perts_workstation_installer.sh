#!/bin/bash
#
# To use:
#
# 1. Download this file.
# 2. Open the Terminal application.
# 3. Copy and paste the following (starting with the word "bash") into Terminal and press return:
#
#    bash ~/Downloads/perts_workstation_installer.sh

echo "==========================="
echo "PERTS Workstation Installer"
echo "==========================="
echo ""
echo "The next step will prompt you to install the XCode command line tools."
echo "Please click the 'Install' button when prompted."
echo ""
read -p "Press return to continue."
echo ""
xcode-select --install

# Brew only supports R version 4 as of 2021-03-11. We use v3.6.3. Will have
# to install manually:
echo "-----------------------------"
echo "Manually download & install R"
echo "-----------------------------"
echo ""
echo "Please download R 3.6.3 from the following URL and install it."
echo "https://cran.r-project.org/bin/macosx/R-3.6.3.nn.pkg"
echo ""
read -p "Press return to continue."
echo ""

echo "---------------"
echo "Installing brew"
echo "---------------"
echo ""
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew tap homebrew/cask

echo "------------------------------------"
echo "Installing packages and apps via brew"
echo "------------------------------------"
echo ""
brew install pyenv
brew install git
brew install node

# Decided not to check if these are already installed manually because
#
# 1. This script is designed for pristine machines which won't have these
# 2. This way brew will install up-to-date versions.
# 3. In the future, it will be easy to check and upgrade versions.

brew install --cask 1password
brew install --cask box-sync
brew install --cask dropbox
brew install --cask github
brew install --cask google-backup-and-sync
brew install --cask google-chrome
brew install --cask google-cloud-sdk
# Java needed for Google Datastore Emulator (running gae apps locally).
brew install --cask java
brew install --cask postman
brew install --cask rstudio
brew install --cask slack
brew install --cask sublime-text
brew install --cask veracrypt

brew cask cleanup

pyenv install 3.9.0
pyenv install 2.7.17

echo "-----------------------------------------"
echo "Setting up Google Cloud SDK a.k.a. gcloud"
echo "-----------------------------------------"
echo ""
echo "The next step will configure gcloud. When prompted:"
echo ""
echo "1. Please use your @perts.net google account."
echo "2. Choose the repository you're most likely to work with."
echo "3. Choose n ('no') when asked to choose a region."
echo "4. Choose Y ('yes') for any other prompts."
echo ""
read -p "Press return to continue."
echo ""
# This modifies the user's PATH so dev_appserver.py is available.
/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/install.sh
source ~/.bash_profile
gcloud init
gcloud components install app-engine-python
gcloud components install app-engine-python-extras

echo "-------------------------------"
echo "How to clone PERTS repositories"
echo "-------------------------------"
echo ""
echo "Refer to the readme of repositories for cloning and installation:"
echo "* https://github.com/PERTS/analysis"
echo "* https://github.com/PERTS/rserve"
echo "* https://github.com/PERTS/neptune"
echo "* https://github.com/PERTS/triton"
echo "* https://github.com/PERTS/saturn"
echo ""
mkdir -p ~/Sites

echo "------------------------------------"
echo "PERTS Workstation Installer Complete"
echo "------------------------------------"
echo ""
echo "Please restart your computer, and have a pleasant day :o)"
