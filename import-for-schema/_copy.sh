#!/bin/bash
# Базовые пути
REMOTE_BASE="ydisk:shared/comfyui/models"
LOCAL_BASE="/workspace/ComfyUI/models"

# Копируем каждый файл
for file in "${FILES[@]}"; do
    echo "Копирую: $file"

    # Создаём директорию назначения
    mkdir -p "$LOCAL_BASE/$(dirname "$file")"

    # Копируем файл в папку назначения
    rclone copy -P "$REMOTE_BASE/$file" "$LOCAL_BASE/$(dirname "$file")"
done