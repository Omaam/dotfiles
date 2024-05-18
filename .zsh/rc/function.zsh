list_py_venvs() {
  echo "Available virtual environments:"
  for venv_dir in "$HOME"/.venv/*/; do
    venv_name=$(basename "$venv_dir")
    echo " - $venv_name"
  done
}


activate_common_venv() {
  if [ $# -eq 0 ]; then
    list_py_venvs
    return 1
  elif [ $# -ne 1 ]; then
    echo "Usage: activate_py_venv <venv_name>"
    return 1
  fi

  venv_name=$1
  activate_script="$HOME/.venv/$venv_name/bin/activate"

  if [ -f "$activate_script" ]; then
    source "$activate_script"
    echo "Activated virtual environment: $venv_name"
  else
    echo "Virtual environment '$venv_name' not found."
    return 1
  fi
}


function activate_project_venv() {
  if [ -d ".venv" ]; then
    source .venv/bin/activate
  else
    echo ".venv/bin/activate does not exist."
    echo "Please create a virtual environment first."
    return 1
  fi
}
