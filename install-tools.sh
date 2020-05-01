#!/bin/bash

#
# Installer for fish shell.
# Do NOT run this with sudo! Specific commands in this script will be executed
# with sudo not all.
#

source utils.sh

if [ $PLATFORM_LINUX -eq 1 ]; then
   step "Installing xclip (clipboard tool)"
   $PKG_INSTALL xclip
   result
fi

step "Installing neovim (replacement for vim)"
$PKG_INSTALL neovim
result
