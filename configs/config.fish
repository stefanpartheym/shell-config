# Bootstrap fisher package manager installation
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# Git aliases
alias gs="git status"
alias gb="git branch"
alias gl="git log --format=oneline --decorate"
alias gg="git gui"
alias gdd="git difftool -d"

function gitworkflow
    set action $argv[1]
    set source $argv[2]
    set destination $argv[3]

    set branch (git rev-parse --abbrev-ref HEAD)

    if test $status -ne 0
        return 1
    end

    if test "$branch" != "$source"
        echo "# ERROR:"
        echo "$action is not allowed for branch '$branch'."
        echo "You must be on branch '$source'."
        return 1
    end

    git checkout $destination
    git merge $source
    git push
    git checkout $source
end

function stage
    gitworkflow "Staging" "develop" "staging"
end

function release
    gitworkflow "Release" "staging" "master"
end
