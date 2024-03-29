#!/bin/bash

#
# Installer for configuration files
#

source utils.sh

source_dir=./configs
destination_dir=~

nvimconfig="init.lua"
fishconfig="config.fish"
fishfile="fish_plugins"
dot_file_gitconfig="gitconfig"
dot_file_tmuxconfig="tmux.conf"
tmux_destination_dir="${destination_dir}/.config/tmux"
tmux_plugins_destination_dir="${tmux_destination_dir}/plugins"

#
# Overwrite configs (git and neovim)
#

install_gitconfig="y"
if [ -f "${destination_dir}/.${dot_file_gitconfig}" ]; then
  prompt install_gitconfig "Git configuration already exists, overwrite? (y/n) " "n"
fi

nvim_config_dir="${destination_dir}/.config/nvim"
install_nvimconfig="y"
if [ -f "${nvim_config_dir}/init.lua" ]; then
  prompt install_nvimconfig "Neovim configuration already exists, overwrite? (y/n) " "n"
fi

#
# Install git config
#

if [ "$install_gitconfig" == "y" ]; then
  current_git_user_email=$(git config user.email)
  current_git_user_name=$(git config user.name)

  step "Configuring git"
  prompt git_user_email "Git user email " "$current_git_user_email" &&
    prompt git_user_name "Git user name " "$current_git_user_name"
  result

  dot_file_gitconfig_content=$(cat "${source_dir}/${dot_file_gitconfig}")
  dot_file_gitconfig_content="${dot_file_gitconfig_content/@git.email@/$git_user_email}"
  dot_file_gitconfig_content="${dot_file_gitconfig_content/@git.name@/$git_user_name}"

  step "Installing gitconfig"
  echo -n "$dot_file_gitconfig_content" >"${destination_dir}/.${dot_file_gitconfig}"
  result
else
  echo "> Keeping current git configuration ..."
fi

#
# Install fish config
#

fish_config_dir="${destination_dir}/.config/fish"
step "Installing fish configuration"
mkdir -p "$fish_config_dir" &&
  cp "${source_dir}/fish/${fishconfig}" "${fish_config_dir}/${fishconfig}" &&
  cp "${source_dir}/fish/${fishfile}" "${fish_config_dir}/${fishfile}"
result

#
# Install tmux config
#

step "Installing tmux configuration"
mkdir -p $tmux_plugins_destination_dir &&
  cp "${source_dir}/${dot_file_tmuxconfig}" "${tmux_destination_dir}/${dot_file_tmuxconfig}" &&
  (
    test -d "${tmux_plugins_destination_dir}/tpm" ||
      git clone https://github.com/tmux-plugins/tpm "${tmux_plugins_destination_dir}/tpm"
  )
result

#
# Install zellij config
#

zellij_config_dir="${destination_dir}/.config/zellij"
zellij_layouts_dir="${zellij_config_dir}/layouts"
step "Installing zellij configuration"
mkdir -p $zellij_config_dir &&
  mkdir -p $zellij_layouts_dir &&
  cp -R $source_dir/zellij/* $zellij_config_dir
result

#
# Install vanilla neovim config
#

if [ "$install_nvimconfig" == "y" ]; then
  step "Installing neovim configuration"
  mkdir -p $nvim_config_dir &&
    cp "${source_dir}/nvim/${nvimconfig}" "${nvim_config_dir}/${nvimconfig}"
  result
else
  echo "> Keeping current neovim configuration ..."
fi
