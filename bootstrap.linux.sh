#!/usr/bin/env bash
set -e
set -u

###############################################################################
# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
###############################################################################

sudo apt upgrade -y

echo "Installing apt tools"
sudo apt -y install \
  bat \
  curl \
  git \
  graphviz \
  npm \
  rsync \
  tldr \
  tmux \
  tree \
  wget \
  vim \
  zsh

# nicer git diffs
npm install -g diff-so-fancy 2> /dev/null

echo "Switch to zsh"
chsh -s /usr/bin/zsh root

echo "Install Oh-My-Zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
