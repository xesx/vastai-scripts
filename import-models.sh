#!/bin/bash
set -e

REMOTE="ydisk"
BASE_REMOTE_PATH="shared/comfyui/models/"
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

# Мультивыбор папок через fzf
SELECTED_FOLDERS=$(printf '%s\n' "${FOLDERS[@]}" | \
  fzf --multi --ansi --marker='++' \
      --prompt="📂 Выбери папки: " \
      --header="⇧↑↓ Tab — выбрать, Enter — скачать" \
      --reverse)

if [[ -z "$SELECTED_FOLDERS" ]]; then
  echo "🚪 Отменено пользователем."
  exit 0
fi

# Преобразуем вывод в массив (без mapfile для совместимости)
FOLDERS_SELECTED=()
while IFS= read -r line; do
  FOLDERS_SELECTED+=("$line")
done <<< "$SELECTED_FOLDERS"

echo "⬇️ Загружаем выбранные папки с сохранением структуры..."

# Копируем каждую выбранную папку
for FOLDER in "${FOLDERS_SELECTED[@]}"; do
  REMOTE_PATH="${BASE_REMOTE_PATH}${FOLDER}/"
  DEST_DIR="${LOCAL_DEST}${FOLDER}"

  echo "📂 Обрабатываем папку: ${FOLDER}"
  mkdir -p "$DEST_DIR"

  echo "📥 ${REMOTE}:${REMOTE_PATH} → $DEST_DIR"
  rclone copy "${REMOTE}:${REMOTE_PATH}" "$DEST_DIR" --progress
done

echo "✅ Все папки успешно загружены!"