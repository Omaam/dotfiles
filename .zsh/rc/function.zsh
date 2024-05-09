create_project_structure() {

  local style="development"

  while getopts n:s: OPT
  do
    case $OPT in
      "n" ) FLG_N="TRUE" ; local project_name="$OPTARG" ;;
      "s" ) FLG_S="TRUE" ; local style="$OPTARG" ;;
        * ) echo "Usage: create_project_structure [-n project_name] [-s style]" 1>&2
            return 1 ;;
    esac
  done

  if [ -z "$project_name" ]; then
    echo "Error: Project name not provided."
    return 1
  fi

  if [ -e "$project_name" ]; then
    echo "Error: '$project_name' directory already exists."
    return 1
  fi

  if [ "$style" = "development" ]; then

    # Create development project structure
    mkdir -p "$project_name/data/external"  # Data from third party sources.
    mkdir -p "$project_name/data/interim"   # Intermediate data that has been transformed.
    mkdir -p "$project_name/data/processed" # The final, canonical data sets for modeling.
    mkdir -p "$project_name/data/raw"       # The original, immutable data dump.
    mkdir -p "$project_name/docker"         # The docker envioronment
    mkdir -p "$project_name/docs"           # A default Sphinx project; see sphinx-doc.org for details
    mkdir -p "$project_name/models"         # Trained and serialized models, model predictions, or model summaries
    mkdir -p "$project_name/notebooks"      # Jupyter notebooks. Naming convention is a number (for ordering),
                                            # the creator's initials, and a short `-` delimited description, e.g.
                                            # `1.0-jqp-initial-data-exploration`.
    mkdir -p "$project_name/references"     # Data dictionaries, manuals, and all other explanatory materials.
    mkdir -p "$project_name/reports"        # Generated analysis as HTML, PDF, LaTeX, etc.
    mkdir -p "$project_name/reports/figures" # Generated graphics and figures to be used in reporting
    mkdir -p "$project_name/src"            # Source code for use in this project.
    mkdir -p "$project_name/src/data"       # Scripts to download or generate data
    mkdir -p "$project_name/src/features"   # Scripts to turn raw data into features for modeling
    mkdir -p "$project_name/src/models"     # Scripts to train models and then use trained models to make
                                            # predictions
    mkdir -p "$project_name/src/visualization" # Scripts to create exploratory and results oriented visualizations
    touch "$project_name/LICENSE"           # License file for the project.
    touch "$project_name/Makefile"          # Makefile with commands like `make data` or `make train`
    touch "$project_name/README.md"         # The top-level README for developers using this project.
    touch "$project_name/requirements.txt"  # The requirements file for reproducing the analysis environment
                                            # generated with `pip freeze > requirements.txt`
    touch "$project_name/setup.py"          # Make this project pip installable with `pip install -e`
    touch "$project_name/docker/Dockerfile"               # Base docker env.
    touch "$project_name/docker/compose.yml"              # How to compose docker env.
    touch "$project_name/src/__init__.py"                 # Makes src a Python module
    touch "$project_name/src/data/make_dataset.py"        # Script to make dataset
    touch "$project_name/src/features/build_features.py"  # Script to build features
    touch "$project_name/src/models/predict_model.py"     # Script to predict model
    touch "$project_name/src/models/train_model.py"       # Script to train model
    touch "$project_name/src/visualization/visualize.py"  # Script to visualize data

  elif [ "$style" = "lecture" ]; then
    # Create lecture project structure
    mkdir -p "$project_name/slides"
    mkdir -p "$project_name/handouts"
    mkdir -p "$project_name/exercises"
    touch "$project_name/README.md"
  else
    echo "Error: Invalid style option."
    return 1
  fi
}

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
