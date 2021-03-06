# Bootstrap fisher package manager installation
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# Configure environment variables
set -gx PATH $PATH $HOME/bin
set -gx EDITOR nvim

# Docker and Kubernetes aliases
alias dc="docker-compose"
alias kc="kubectl"

# Git aliases
alias gs="git status"
alias gb="git branch"
alias gl="git log --format=oneline --decorate"
alias gcm="git commit -m"
alias gg="git gui"
function gdd --wraps='git difftool -d' --description 'alias gdd=git difftool -d'
  git difftool -d $argv &
end

# Aliases for git extensions (stefanpartheym/fish-git-extensions.git)
alias gcob="gitext_checkout"
alias gadd="gitext_add"
alias stage="gitext_stage"
alias release="gitext_release"
