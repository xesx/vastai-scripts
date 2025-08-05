#!/bin/bash
# Массив файлов для копирования
FILES=(
    "clip/clip_l.safetensors"
    "clip/t5-v1_1-xxl-encoder-Q4_K_S.gguf"
    "vae/Flux-vae.safetensors"
    "diffusion_models/flux1-dev-fp8-e4m3fn.safetensors"
)

source ${VASTAI_SCRIPTS_DIR}/import-for-schema/_copy.sh