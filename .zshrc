# zsh
source_target_files=($HOME/.zsh.local/.zshrc)
source_target_files=(
  $source_target_files
  `find $HOME/.zsh/* -print`
)
for f in "$source_target_files[@]"; do
  if [ -e $f ]; then
    source $f
  fi
done


# oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=()
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh


# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"


# Common favored settings
export CDPATH=$HOME:$(cd && ls -d */ | sed -e "s|^|$HOME/|" -e "s|/$||" | tr "\n" ":")..
export PATH=$PATH:$HOME/.bin
alias cdp="cd $PROJECT && pwd"
alias peakdl='open "$(find $HOME/Downloads/* -print0 | xargs -0 ls -t | head -1)"'
alias grabdl='mv "$(find $HOME/Downloads/* -print0 | xargs -0 ls -t | head -1)" .'


# Update $HOME/.ALLFILES
local allfiles="$HOME/.ALLFILES"
if [ ! -e $allfiles ]; then
  echo "Create $allfiles in the background"
  ff -u &> /dev/null & disown
elif [ -n "$(find $allfiles -mtime +0 -print)" ]; then
  echo "Update $allfiles in the background" \
       "since this was modified more than one day ago"
  ff -u &> /dev/null & disown
fi
