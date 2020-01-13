#!/usr/bin/env bash
set -e
set -u

echo "Begin setting up Mac..."

###############################################################################
# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
###############################################################################

# don't take analytics
export HOMEBREW_NO_ANALYTICS=1

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  echo "Installing HomeBrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Start brewing"
# Turn off analytics
brew analytics off

# Make sure we’re using the latest Homebrew.
brew update
brew upgrade
brew cask upgrade

# install from Brewfile
# || true, because sometimes some packages fail.
# If this happens, we'll still try to continue...
brew bundle || true

# cleanup after brewing
brew cleanup
echo "Finished brewing"

# set Chrome as default browser
open -a "Google Chrome" --args --make-default-browser

echo "Switch to zsh"
chsh -s /bin/zsh

if [[ ! -r "${HOME}/.oh-my-zsh" ]]; then
    echo "Install Oh-My-Zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Wipe all (default) app icons from the Dock
# This is only really useful when setting up a new Mac, or if you don’t use
# the Dock to launch apps.
# defaults write com.apple.dock persistent-apps -array

echo "Setting Mac Defaults"
sh macos.defaults.sh
