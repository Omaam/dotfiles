source_target_files=(`find $HOME/.zsh/*/*.zsh -type f -print`)
for f in "$source_target_files[@]"; do source $f; done

# zsh
HISTSIZE=1000000
HISTFILESIZE=1000000


# tmux
if [[ ! -e $HOME/.tmux/plugins/tpm ]]; then
  git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
fi

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
