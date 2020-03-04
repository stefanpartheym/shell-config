#!/bin/bash

#
# Installer for configuration files
#

source utils.sh

source_dir=./configs
destination_dir=~

dot_file_gitconfig="gitconfig"

step "Configuring git"
read -p "Git user email: " git_user_email && \
read -p "Git user name: " git_user_name
result

dot_file_gitconfig_content=`cat "${source_dir}/${dot_file_gitconfig}"`
dot_file_gitconfig_content="${dot_file_gitconfig_content/@git.email@/$git_user_email}"
dot_file_gitconfig_content="${dot_file_gitconfig_content/@git.name@/$git_user_name}"

step "Installing gitconfig"
echo -n "$dot_file_gitconfig_content" > "${destination_dir}/.${dot_file_gitconfig}"
result

