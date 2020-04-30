#!/usr/bin/env bash
set -e
set -u

###############################################################################
# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
###############################################################################
sudo apt-get update -y -qq
sudo apt-get upgrade -y -qq

echo "Installing packages via apt-get"
sudo apt-get -y -qq install bat || true
sudo apt-get -y -qq install curl || true
sudo apt-get -y -qq install git || true
sudo apt-get -y -qq install graphviz || true
sudo apt-get -y -qq install rsync || true
sudo apt-get -y -qq install tmux || true
sudo apt-get -y -qq install tree || true
sudo apt-get -y -qq install wget || true
sudo apt-get -y -qq install vim || true
sudo apt-get -y -qq install zsh || true

# install linuxbrew 
sudo apt-get -y -qq install build-essential  # should be necessary for brew
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)  # adds brew to the path
brew install gcc  # recommended by brew

echo "Start brewing"
# Turn off analytics
brew analytics off

brew update
brew upgrade

# install from Brewfile
# || true, because sometimes some packages fail.
# If this happens, we'll still try to continue...
brew bundle || true

# cleanup after brewing
brew cleanup
echo "Finished brewing"



echo "Switch to zsh"
chsh -s /usr/bin/zsh

echo "Install Oh-My-Zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# snaps
sudo snap install --classic atom || true
sudo snap install docker || true
sudo snap install chromium || true
sudo snap install python38 || true
sudo snap install vlc || true
