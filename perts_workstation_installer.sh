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
read -p "Press any key to continue."
xcode-select --install

echo "---------------"
echo "Installing brew"
echo "---------------"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew tap homebrew/cask

echo "------------------------------------"
echo "Installing packages and apps via brew"
echo "------------------------------------"
brew install python@2
brew install git
brew install node
brew cask install 1password
brew cask install box-sync
brew cask install dropbox
brew cask install github
brew cask install google-backup-and-sync
brew cask install google-chrome
brew cask install google-cloud-sdk
brew cask install slack
brew cask install sublime-text
brew cask install veracrypt

echo "-----------------------------------------"
echo "Setting up Google Cloud SDK a.k.a. gcloud"
echo "-----------------------------------------"
echo ""
echo "The next step will configure gcloud."
echo "Please use your @perts.net google account, and choose the repository you're most likely to work with."
read -p "Press any key to continue."
echo ""
gcloud init
gcloud components install app-engine-python
gcloud components install app-engine-python-extras

echo "--------------------------"
echo "Cloning PERTS repositories"
echo "--------------------------"
mkdir -p ~/Sites
cd ~/Sites
# Choosing these repos because they're the ones non-devs (who benefit most from
# automation) are most likely to contribute to.
git clone https://github.com/PERTS/yellowstone.git
git clone https://github.com/PERTS/mindsetkit.git

echo "------------------------------------"
echo "PERTS Workstation Installer Complete"
echo "------------------------------------"
echo ""
echo "Please restart your computer, and have a pleasant day :o)"
