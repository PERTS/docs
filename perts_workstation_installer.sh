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
brew install python@2
brew install git
brew install node

# Decided not to check if these are already installed manually because
#
# 1. This script is designed for pristine machines which won't have these
# 2. This way brew will install up-to-date versions.
# 3. In the future, it will be easy to check and upgrade versions.

brew cask install 1password
brew cask install box-sync
brew cask install dropbox
brew cask install github
brew cask install google-backup-and-sync
brew cask install google-chrome
brew cask install google-cloud-sdk
brew cash install postman
brew cask install r-app
brew cask install rstudio
brew cask install slack
brew cask install sublime-text
brew cask install veracrypt

brew cask cleanup

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
gcloud init
gcloud components install app-engine-python
gcloud components install app-engine-python-extras

echo "--------------------------"
echo "Cloning PERTS repositories"
echo "--------------------------"
echo ""
mkdir -p ~/Sites
# Choosing these repos because they're the ones non-devs (who benefit most from
# automation) are most likely to contribute to.
if [ ! -d "$HOME/Sites/yellowstone" ]
then
  git clone https://github.com/PERTS/yellowstone.git $HOME/Sites/yellowstone
fi
if [ ! -d "$HOME/Sites/mindsetkit" ]
then
  git clone https://github.com/PERTS/mindsetkit.git $HOME/Sites/mindsetkit
fi

echo "------------------------------------"
echo "PERTS Workstation Installer Complete"
echo "------------------------------------"
echo ""
echo "Please restart your computer, and have a pleasant day :o)"
