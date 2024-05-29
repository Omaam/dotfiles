function pyactivate() {

  current_dir=$(pwd)

  # $HOMEディレクトリに到達するまでループ
  while [ "$current_dir" != "$HOME" ]; do
      if [ -d "$current_dir/.venv" ]; then
          break
      fi
      current_dir=$(dirname "$current_dir")
  done

  if [ $current_dir = $HOME ]; then
    echo ".venv directory not found."
    echo "Please create a virtual environment first."
    return 1
  fi

  echo "source $current_dir/.venv/bin/activate"
  source "$current_dir/.venv/bin/activate"
  return 0
}
