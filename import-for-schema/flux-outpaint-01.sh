#!/bin/bash

# Массив файлов для копирования
FILES=(
    "clip/clip_l.safetensors"
    "clip/t5-v1_1-xxl-encoder-Q4_K_S.gguf"
    "vae/Flux-vae.safetensors"
    "diffusion_models/flux1-fill-dev-FP8.safetensors"
)

# Получаем директорию, где находится скрипт
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/_copy.sh"
