#!/bin/bash

#
# Installer for configuration files
#

source utils.sh

source_dir=./configs
destination_dir=~

nvimconfig="init.vim"
fishconfig="config.fish"
fishfile="fish_plugins"
dot_file_gitconfig="gitconfig"
dot_file_tmuxconfig="tmux.conf"

install_gitconfig="y"

if [ -f "${destination_dir}/.${dot_file_gitconfig}" ]; then
    prompt install_gitconfig "Git configuration already exists, overwrite? (y/n) " "n"
fi

if [ "$install_gitconfig" == "y" ]; then
    current_git_user_email=`git config user.email`
    current_git_user_name=`git config user.name`

    step "Configuring git"
    prompt git_user_email "Git user email " "$current_git_user_email" && \
    prompt git_user_name "Git user name " "$current_git_user_name"
    result

    dot_file_gitconfig_content=`cat "${source_dir}/${dot_file_gitconfig}"`
    dot_file_gitconfig_content="${dot_file_gitconfig_content/@git.email@/$git_user_email}"
    dot_file_gitconfig_content="${dot_file_gitconfig_content/@git.name@/$git_user_name}"

    step "Installing gitconfig"
    echo -n "$dot_file_gitconfig_content" > "${destination_dir}/.${dot_file_gitconfig}"
    result
else
    echo "> Keeping current git configuration ..."
fi

step "Installing fish configuration"
fish_config_dir="${destination_dir}/.config/fish"
mkdir -p "$fish_config_dir" && \
cp "${source_dir}/fish/${fishconfig}" "${fish_config_dir}/${fishconfig}" && \
cp "${source_dir}/fish/${fishfile}" "${fish_config_dir}/${fishfile}"
result

step "Installing tmux configuration"
cp "${source_dir}/${dot_file_tmuxconfig}" "${destination_dir}/.${dot_file_tmuxconfig}"
result

nvim_config_dir="${destination_dir}/.config/nvim"
step "Installing vim configuration files (nvim)"
mkdir -p $nvim_config_dir && \
mkdir -p ${nvim_config_dir}/ftplugin && \
cp "${source_dir}/nvim/${nvimconfig}" "${nvim_config_dir}/${nvimconfig}" && \
cp ${source_dir}/nvim/ftplugin/* "${nvim_config_dir}/ftplugin/" && \
result
