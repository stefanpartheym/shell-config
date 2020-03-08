# Installer utils

################################################################################
# functions
################################################################################

function step {
    echo "$1:"
}

function result {
    if [ $? -eq 0 ]; then
        echo "  => SUCCESS"
    else
        echo "  => FAILED"
        exit 1
    fi
}

function prompt {
    read_args=""
    read_prompt=""

    if [ -n "$2" ]; then
        read_args="-p"
        read_prompt="$2"
        if [ -n "$3" ]; then
            read_prompt="$read_prompt[$3] "
        fi
    fi

    read $read_args "$read_prompt" $1

    if [ -n "$3" ] && [ -z "${!1}" ]; then
        eval "${1}=\"${3}\""
    fi
}

function replace {
    echo "${1//\{\{$2\}\}/$3}"
}

################################################################################
# variables
################################################################################

unset PLATFORM_LINUX
unset PLATFORM_MAC

case "`uname`" in
    "Linux")  export PLATFORM_LINUX=1;;
    "Darwin") export PLATFORM_MAC=1;;
esac

if [[ "$PLATFORM_MAC" -eq 1 ]]; then
    PKG_INSTALL="brew install"
else
    PKG_INSTALL="yay -S"
fi
