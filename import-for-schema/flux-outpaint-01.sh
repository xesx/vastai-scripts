#!/bin/bash
# Массив файлов для копирования
FILES=(
    "clip/clip_l.safetensors"
    "clip/t5-v1_1-xxl-encoder-Q4_K_S.gguf"
    "vae/Flux-vae.safetensors"
    "diffusion_models/flux1-fill-dev-FP8.safetensors"
)

# Копируем каждый файл
for file in "${FILES[@]}"; do
    echo "Копирую: $file"
    rclone copy -P "$REMOTE_BASE/$file" "$LOCAL_BASE/$file"
done