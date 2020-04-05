# Bootstrap fisher package manager installation
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# Configure PATH
set -gx PATH $PATH ~/bin

# Docker aliases
alias dc="docker-compose"

# Git aliases
alias gs="git status"
alias gb="git branch"
alias gl="git log --format=oneline --decorate"
alias gg="git gui"
alias gdd="git difftool -d"

# Aliases for git extensions (stefanpartheym/fish-git-extensions.git)
alias gcob="gitext_checkout"
alias gadd="gitext_add"
alias stage="gitext_stage"
alias release="gitext_release"
