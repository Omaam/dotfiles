#!/bin/bash

set_installer() {
    if [[ "$(uname)" == "Linux" ]]; then
        if [ -f /etc/os-release ]; then
            source /etc/os-release
            if [[ $ID == "ubuntu" ]]; then
                INSTALLER="apt-get"
            elif [[ $ID == "centos" ]]; then
                INSTALLER="yum"
            else
                echo "Unsupported Linux distribution"
                exit 1
            fi
        else
            echo "Unsupported Linux distribution"
            exit 1
        fi
    elif [[ "$(uname)" == "Darwin" ]]; then
        INSTALLER="brew"
    else
        echo "Unsupported operating system"
        exit 1
    fi
}

install_required_commands() {

    # Add required commands
    commands=("curl" "git" "zsh")

    for cmd in "${commands[@]}"; do
        if ! command -v "$cmd" &> /dev/null; then
            echo "Installing $cmd..."
            sudo "$installer" install -y "$cmd"
        else
            echo "$cmd is already installed."
        fi
    done
}

setup_environment() {

    echo "backup old dotfiles..."
    if [ ! -d "$HOME/.dotbackup" ];then
        echo "$HOME/.dotbackup not found. Auto Make it"
        mkdir "$HOME/.dotbackup"
    fi

    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
    local dotdir=$(dirname ${script_dir})
    if [[ "$HOME" != "$dotdir" ]];then
        for f in $dotdir/.??*; do

        [[ `basename $f` == ".git" ]] && continue
        [[ `basename $f` == ".gitignore" ]] && continue

        if [[ -L "$HOME/`basename $f`" ]];then
            rm -f "$HOME/`basename $f`"
        fi
        if [[ -e "$HOME/`basename $f`" ]];then
            mv "$HOME/`basename $f`" "$HOME/.dotbackup"
        fi

        ln -snf $f $HOME

        done
    else
        echo "same install src dest"
    fi
}

setup_os_specific() {
    if [ "$INSTALLER" == "brew" ]; then
        brew bundle --file $HOME/dotfiles/.brew/Brewfile
    fi
}


main() {
    set_installer
    install_required_commands
    setup_environment
    setup_os_specific
}

# Main実行
main