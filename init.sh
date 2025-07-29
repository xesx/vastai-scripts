#!/bin/bash

# Получаем путь к самому исполняемому скрипту
SCRIPT_PATH="$(realpath "$0")"
export VASTAI_SCRIPTS_DIR="$(dirname "$SCRIPT_PATH")"

TARGET_SCRIPT="$VASTAI_SCRIPTS_DIR/import-from-ydisk.sh"
ALIAS_NAME="yaimport"

# Определяем файл конфигурации shell'а
if [[ $SHELL == */zsh ]]; then
    SHELL_RC="$HOME/.zshrc"
else
    SHELL_RC="$HOME/.bashrc"
fi

echo TARGET_SCRIPT: "$TARGET_SCRIPT"

# Добавляем алиас, если его ещё нет
if grep -q "alias $ALIAS_NAME=" "$SHELL_RC"; then
    echo "Алиас '$ALIAS_NAME' уже существует в $SHELL_RC"
else
    echo "alias $ALIAS_NAME=\"$TARGET_SCRIPT\"" >> "$SHELL_RC"
    echo "Алиас '$ALIAS_NAME' добавлен в $SHELL_RC"
    echo "Чтобы применить изменения, запусти: source $SHELL_RC"
fi
