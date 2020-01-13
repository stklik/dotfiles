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
# sudo apt-get -y -qq install npm node-gyp || true
sudo apt-get -y -qq install rsync || true
sudo apt-get -y -qq install tldr || true
sudo apt-get -y -qq install tmux || true
sudo apt-get -y -qq install tree || true
sudo apt-get -y -qq install tree || true
sudo apt-get -y -qq install wget || true
sudo apt-get -y -qq install vim || true
sudo apt-get -y -qq install zsh || true

# nicer git diffs
# npm install -g diff-so-fancy 2> /dev/null

echo "Switch to zsh"
chsh -s /usr/bin/zsh root

echo "Install Oh-My-Zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
