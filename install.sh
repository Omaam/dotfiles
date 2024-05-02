#!/bin/bash


set_installer() {
    if [[ "$(uname)" == "Linux" ]]; then
        if [ -f /etc/os-release ]; then
            source /etc/os-release
            if [[ $ID == "ubuntu" ]]; then
                installer="apt"
            elif [[ $ID == "centos" ]]; then
                installer="yum"
            else
                echo "Unsupported Linux distribution"
                exit 1
            fi
        else
            echo "Unsupported Linux distribution"
            exit 1
        fi
    elif [[ "$(uname)" == "Darwin" ]]; then
        installer="brew"
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
            if [[ "$HOME" == "/root" ]]; then
                "$installer" install -y "$cmd"
            else
                echo $installer
                if [[ "$installer" == "brew" ]]; then
                    "$installer" update
                    "$installer" upgrade
                    "$installer" install -y "$cmd"
                else
                    sudo "$installer" update -y
                    sudo "$installer" upgrade -y
                    sudo "$installer" install -y "$cmd"
                fi
            fi
        else
            echo "$cmd exists ... not installed"
        fi
    done
}


clone_dotfiles() {
    if [ ! -d ${dotdir} ]; then
      if command -v "git" &> /dev/null; then
        git clone https://github.com/Omaam/dotfiles.git ${dotdir}
      else
        echo "git required"
        exit 1
      fi
    else
      echo "dotfiles exists ... not installed, just update"
    fi
}


setup_environment() {

    echo "backup old dotfiles..."
    if [ ! -d "$HOME/.dotbackup" ];then
        echo "$HOME/.dotbackup not found. Auto Make it"
        mkdir "$HOME/.dotbackup"
    fi

    for f in $dotdir/.??*; do

      [[ `basename $f` == ".git" ]] && continue
      [[ `basename $f` == ".gitignore" ]] && continue

      # Check if file is symbolic link or not.
      if [[ -L "$HOME/`basename $f`" ]];then
          rm -f "$HOME/`basename $f`"
      fi

      # Check if file exists.
      if [[ -e "$HOME/`basename $f`" ]];then
          mv "$HOME/`basename $f`" "$HOME/.dotbackup"
      fi

      ln -snf $f $HOME

    done
}


setup_os_specific() {
    if [[ "$installer" == "brew" ]]; then
        "$installer" update
        "$installer" upgrade
        brew bundle \
          --no-lock \
          --file $HOME/dotfiles/.brew/Brewfile
    fi
}


main() {

    local dotdir=$HOME/dotfiles

    set_installer
    install_required_commands
    clone_dotfiles
    setup_environment
    setup_os_specific
}


main
