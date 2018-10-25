#!/bin/bash
#
# To use:
#
# 1. Download this file.
# 2. Open the Terminal application.
# 3. Copy and paste the following (starting with the word "bash") into Terminal and press return:
#
#    bash ~/Downloads/veracrypt_installer.sh

echo "==========================="
echo "PERTS VeraCrypt Installer"
echo "==========================="
echo ""
echo "---------------"
echo "Installing brew"
echo "---------------"
echo ""
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew tap homebrew/cask
echo "--------------------"
echo "Installing VeraCrypt"
echo "--------------------"
echo ""
brew cask install veracrypt
brew cask cleanup
echo "------------------"
echo "Installer Complete"
echo "------------------"
echo ""
echo "Have a pleasant day :o)"
