#!/bin/bash
set -e

REMOTE="ydisk"
BASE_REMOTE_PATH="comfyui-link-source/models/"
LOCAL_DEST="/workspace/ComfyUI/models/"

echo "📁 Сканируем доступные папки..."

# Получаем список подкаталогов внутри BASE_REMOTE_PATH (без файлов)
FOLDERS=()
while IFS= read -r line; do
  FOLDERS+=("${line%/}") # убираем / с конца
done < <(rclone lsf "${REMOTE}:${BASE_REMOTE_PATH}" --dirs-only)

if [[ ${#FOLDERS[@]} -eq 0 ]]; then
  echo "❌ Нет папок в ${REMOTE}:${BASE_REMOTE_PATH}"
  exit 1
fi

# Выбор папки через fzf
SELECTED_FOLDER=$(printf '%s\n' "${FOLDERS[@]}" | \
  fzf --prompt="📂 Выбери папку: " --header="Enter — скачать папку целиком" --reverse)

if [[ -z "$SELECTED_FOLDER" ]]; then
  echo "🚪 Отменено пользователем."
  exit 0
fi

REMOTE_PATH="${BASE_REMOTE_PATH}${SELECTED_FOLDER}/"
echo "📂 Скачиваем папку: ${REMOTE_PATH}"

# Путь назначения
DEST_DIR="${LOCAL_DEST}${SELECTED_FOLDER}"
#mkdir -p "$DEST_DIR"

# Копируем всю папку целиком
echo "⬇️ Загружаем папку целиком с сохранением структуры..."
SRC="${REMOTE}:${REMOTE_PATH}"
DEST="${DEST_DIR}"
echo "📥 $SRC → $DEST"
#rclone copy "$SRC" "$DEST" --progress

echo "✅ Загрузка завершена!"