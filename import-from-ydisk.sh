#!/bin/bash
set -e

REMOTE="ydisk"
REMOTE_PATH="comfyui-link-source/models/checkpoints/"
LOCAL_DEST="/workspace/ComfyUI/models/checkpoints/"

echo "📂 Получаем список файлов с Яндекс.Диска..."

# Получаем список файлов (только файлы, не папки)
mapfile -t FILES < <(rclone lsf -R "${REMOTE}:${REMOTE_PATH}" --files-only)

if [[ ${#FILES[@]} -eq 0 ]]; then
  echo "❌ Нет доступных файлов на ${REMOTE}:${REMOTE_PATH}"
  exit 1
fi

# fzf мультиселект
# SELECTED_FILES=$(printf '%s\n' "${FILES[@]}" | fzf --multi --prompt="Выбери файлы: " --header="⇧↑↓⇩ Space — выбрать, Enter — скачать")
SELECTED_FILES=$(printf '%s\n' "${FILES[@]}" | \
  fzf --multi --ansi --marker='++' \
      --prompt="Выбери файлы: " \
      --header="⇧↑↓⇩ Space — выбрать, Enter — скачать" \
      --reverse)

if [[ -z "$SELECTED_FILES" ]]; then
  echo "🚪 Отменено пользователем."
  exit 0
fi

echo "⬇️ Загружаем выбранные файлы..."

while IFS= read -r FILE; do
  echo "📥 $FILE"
  rclone copy -P "${REMOTE}:${REMOTE_PATH}${FILE}" "${LOCAL_DEST}"
done <<< "$SELECTED_FILES"

echo "✅ Загрузка завершена!"
