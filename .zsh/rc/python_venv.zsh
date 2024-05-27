function pyactivate() {
  if [ -d ".venv" ]; then
    source .venv/bin/activate
  else
    echo ".venv/bin/activate does not exist."
    echo "Please create a virtual environment first."
    return 1
  fi
}
