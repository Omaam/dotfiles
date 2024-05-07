# oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=()
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# Source settings
source_target_files=(
  $HOME/.zsh/rc/function.zsh
  $HOME/.zsh.local/rc/function.zsh
  $HOME/.zsh.local/.zshrc
)
for f in "$source_target_files[@]"; do
  if [ -e $f ]; then
    source $f
  fi
done


# ========== Common favored settings ==========

# Useful CDPATH (ref. Efficient Linux at the Command Line).
export CDPATH="$HOME:$HOME/Work:$HOME/Data:.."

# Short cut to the current main project.
alias cdp="cd $PROJECT && pwd"
