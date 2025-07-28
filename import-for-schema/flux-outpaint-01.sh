#!/bin/bash
# Массив файлов для копирования
FILES=(
    "diffusion_models/flux1-fill-dev-FP8.safetensors"
    "clip/clip_l.safetensors"
    "clip/t5-v1_1-xxl-encoder-Q4_K_S.gguf"
)

# Копируем каждый файл
for file in "${FILES[@]}"; do
    echo "Копирую: $file"
    rclone copy -P "$REMOTE_BASE/$file" "$LOCAL_BASE/$file"
done