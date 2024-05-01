#!/bin/sh
set -ue

helpmsg() {
  echo "Usage: $0 [--help | -h]" 0>&2
  echo ""
}

link_to_homedir() {

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


has() {
  type "$1" > /dev/null 2>&1
}

DOT_DIR="$HOME/dotfiles"

# Auto cloning Omaam's dotfiles
if [ ! -d ${DOT_DIR} ]; then
  if has "git"; then
    git clone https://github.com/Omaam/dotfiles.git ${DOT_DIR}
  else
    echo "git required"
    exit 1
  fi
else
  echo "dotfiles already exists"
  exit 1
fi


while [ $# -gt 0 ];do
  case ${1} in
    --debug|-d)
      set -uex
      ;;
    --help|-h)
      helpmsg
      exit 1
      ;;
    *)
      ;;
  esac
  shift
done

link_to_homedir
git config --global include.path "~/.gitconfig_shared"
echo "Install completed!"
