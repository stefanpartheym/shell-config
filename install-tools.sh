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

step "Installing fzf (fuzzy finder)"
$PKG_INSTALL fzf
result

step "Installing zoxide (replacement for cd)"
$PKG_INSTALL zoxide
result

step "Installing eza (replacement for ls)"
$PKG_INSTALL eza
result

step "Installing bat (replacement for cat)"
$PKG_INSTALL bat
result

step "Installing fd (replacement for locate)"
$PKG_INSTALL fd
result

step "Installing ripgrep (replacement for grep)"
$PKG_INSTALL ripgrep
result

step "Installing jq (Command-line JSON processor)"
$PKG_INSTALL jq
result

step "Installing delta (git diff pager)"
$PKG_INSTALL git-delta
result

step "Installing tmux"
$PKG_INSTALL tmux
result

step "Installing yazi and dependencies (cli file manager)"
$PKG_INSTALL yazi unarchiver ffmpegthumbnailer poppler
result

step "Installing neovim (replacement for vim)"
$PKG_INSTALL neovim
result
