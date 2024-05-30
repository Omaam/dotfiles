chproj() {
  local NEW_PROJECT_PATH=""
  local VARIABLES_FILE="$HOME/.zsh/local/variables.zsh"

  # オプションの解析
  while getopts ":h" opt; do
    case ${opt} in
      h )
        NEW_PROJECT_PATH="$PWD"
        ;;
      \? )
        echo "Invalid option: -$OPTARG" 1>&2
        echo "Usage: chproj [-h] <new_project_path>"
        return 1
        ;;
    esac
  done
  shift $((OPTIND -1))

  # 引数の処理
  if [ -z "$NEW_PROJECT_PATH" ]; then
    if [ -n "$1" ]; then
      NEW_PROJECT_PATH="$1"
    else
      echo "Usage: chproj [-h] <new_project_path>"
      return 1
    fi
  fi

  # ファイルが存在しない場合には作成する
  if [ ! -f "$VARIABLES_FILE" ]; then
    mkdir -p "$(dirname "$VARIABLES_FILE")"
    touch "$VARIABLES_FILE"
  fi

  # 変数の値を更新する
  if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' "s|^PROJECT=.*|PROJECT=\"$NEW_PROJECT_PATH\"|" $VARIABLES_FILE
  else
    sed -i "s|^PROJECT=.*|PROJECT=\"$NEW_PROJECT_PATH\"|" $VARIABLES_FILE
  fi

  # 更新された変数ファイルをソースする
  source "$VARIABLES_FILE"

  echo "PROJECT has been changed to $NEW_PROJECT_PATH and $VARIABLES_FILE has been reloaded."
}
