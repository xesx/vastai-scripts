#!/bin/bash
# Массив файлов для копирования
FILES=(
#    "clip/clip_l.safetensors"
#    "clip/t5-v1_1-xxl-encoder-Q4_K_S.gguf"
    "vae/Flux-vae.safetensors"
    "diffusion_models/flux1-fill-dev-FP8.safetensors"
    "clip_vision/flux_clip_vision_patch14_384.safetensors"
    "style_models/flux1-redux-dev.safetensors"
)

source ${VASTAI_SCRIPTS_DIR}/import-for-schema/_copy.sh