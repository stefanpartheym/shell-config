#!/bin/bash

#
# Installer for fish shell
#

source utils.sh

step "Installing fish shell"
$PKG_INSTALL fish
result

step "Installing fisher package manager"
fish -c "curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish"
result

step "Installing fish packages"
fish -c "fisher add rafaelrinaldi/pure" && \
fish -c "fisher add stefanpartheym/fish-git-extensions"
result

fish_path=`which fish`

step "Configuring fish as default shell"

cat /etc/shells | grep fish > /dev/null || \
sudo bash -c "echo \"$fish_path\" >> /etc/shells" && \
chsh -s $fish_path
result
