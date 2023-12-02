#!/bin/bash

#
# Installer for additional tools (tmux, nvim, ...).
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

step "Installing eza (replacement for ls)"
$PKG_INSTALL eza
result

step "Installing tmux"
$PKG_INSTALL tmux
result
