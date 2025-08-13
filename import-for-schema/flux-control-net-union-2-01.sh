#!/bin/bash
# Массив файлов для копирования
FILES=(
    "clip/clip_l.safetensors"
    "clip/t5xxl_fp8_e4m3fn.safetensors"
    "vae/Flux-vae.safetensors"
    "diffusion_models/flux1-dev-fp8-e4m3fn.safetensors"
    "controlnet/flux/flux-1-dev-control-net-union-pro-2-0-fp16.safetensors"
)

source ${VASTAI_SCRIPTS_DIR}/import-for-schema/_copy.sh