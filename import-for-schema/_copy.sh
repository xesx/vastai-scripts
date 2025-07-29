#!/bin/bash
# Базовые пути
REMOTE_BASE="ydisk:shared/comfyui/models"
LOCAL_BASE="/workspace/ComfyUI/models"

# Копируем каждый файл
for file in "${FILES[@]}"; do
    echo "Копирую: $file"
    rclone copy -P "$REMOTE_BASE/$file" "$LOCAL_BASE/$file"
done