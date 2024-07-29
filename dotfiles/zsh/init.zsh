for f in `find $HOME/.zsh/essential/*.zsh`; do
  source $f
done

function load_shell_files {
  local option=$1
  local dir

  case $option in
    --rc)
      dir=~/.zsh/rc
      ;;
    --local)
      dir=~/.zsh/local
      ;;
    --functions)
      dir=~/.zsh/functions
      ;;
    *)
      echo "Usage: load_shell_files [--rc|--local|--functions]"
      return 1
      ;;
  esac

  local f
  for f in $dir/*.zsh; do
    source $f
  done
}
alias load_rc='load_shell_files --rc'
alias load_local='load_shell_files --local'
alias load_functions='load_shell_files --functions'
alias ldl='load_local'
