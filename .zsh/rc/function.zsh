create_project_structure() {

      if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
          echo "Usage: create_project_structure <project_name>"
          echo "Creates a directory structure for a project."
          return
      fi

    # Check if project name is provided
    if [ -z "$1" ]; then
        echo "Error: Project name not provided."
        return 1
    fi

    project_name="$1"

    # Create project directory
    mkdir -p "$project_name"

    # Create directories
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

    # Create files
    touch "$project_name/LICENSE"           # License file for the project.
    touch "$project_name/Makefile"          # Makefile with commands like `make data` or `make train`
    touch "$project_name/README.md"         # The top-level README for developers using this project.
    touch "$project_name/requirements.txt"  # The requirements file for reproducing the analysis environment
                                            # generated with `pip freeze > requirements.txt`
    touch "$project_name/setup.py"          # Make this project pip installable with `pip install -e`
    # touch "$project_name/tox.ini"           # tox file with settings for running tox; see tox.readthedocs.io

    touch "$project_name/docker/Dockerfile"               # Docker env.
    touch "$project_name/docker/docker-compose.yml"       # How to compose docker env.
    touch "$project_name/src/__init__.py"                 # Makes src a Python module
    touch "$project_name/src/data/make_dataset.py"        # Script to make dataset
    touch "$project_name/src/features/build_features.py"  # Script to build features
    touch "$project_name/src/models/predict_model.py"     # Script to predict model
    touch "$project_name/src/models/train_model.py"       # Script to train model
    touch "$project_name/src/visualization/visualize.py"  # Script to visualize data
}

list_py_venvs() {
    echo "Available virtual environments:"
    for venv_dir in "$HOME"/.venv/*/; do
        venv_name=$(basename "$venv_dir")
        echo " - $venv_name"
    done
}

activate_py_venv() {
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
