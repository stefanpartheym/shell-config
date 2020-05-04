#!/bin/bash

#
# Installer for fish shell.
# Do NOT run this with sudo! Specific commands in this script will be executed
# with sudo not all.
#

source utils.sh

step "Installing fish shell"
$PKG_INSTALL fish
result

fish_path=`which fish`

step "Configuring fish as default shell"
cat /etc/shells | grep fish > /dev/null || \
sudo bash -c "echo \"$fish_path\" >> /etc/shells" && \
chsh -s $fish_path
result
