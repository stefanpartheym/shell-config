#
# Bootstrap package manager
#
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c "fisher update"
end

#
# Setup environment
#

# Disable fish greeting
set fish_greeting
# Configure environment variables
set -gx PATH $PATH $HOME/.local/bin
set -gx EDITOR nvim

#
# Setup aliases
#

# Git
if type -f git &>/dev/null
    alias gs="git status"
    alias gb="git branch"
    alias gl="git log --format=oneline --decorate"
    alias gcm="git commit -m"
    function gdd --wraps='git difftool -d' --description 'alias gdd=git difftool -d'
        git difftool -d $argv &
    end
    # Aliases for git extensions (stefanpartheym/fish-git-extensions.git)
    alias gcob="gitext_checkout"
    alias gadd="gitext_add"
end
# Docker
if type -f docker-compose &>/dev/null
    alias dc="docker-compose"
end
# Kubernetes
if type -f kubectl &>/dev/null
    alias kc="kubectl"
end
# Other
if type -f eza &>/dev/null
    alias ls="eza --icons"
    alias la="ls -la"
end

#
# Setup functions
#

# Create or attach to the default session
function td --description 'Open tmux default session'
    set session_name default
    if tmux ls 2>/dev/null | cut -d ':' -f 1 | grep -qE "^$session_name\$"
        tmux attach -t "$session_name"
    else
        tmux new -s "$session_name"
    end
end

#
# Setup tools
#

if type -f zoxide &>/dev/null
    zoxide init fish | source
end

#
# Load custom config
#
if test -f ~/.config/fish/custom.fish
    source ~/.config/fish/custom.fish
end
