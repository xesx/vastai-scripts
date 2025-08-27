#!/bin/bash
# Массив файлов для копирования
FILES=(
    "clip/clip_l.safetensors"
    "clip/t5-v1_1-xxl-encoder-Q4_K_S.gguf"
    "vae/flux-vae-fp-16.safetensors"
    "diffusion_models/flux1-dev-fp8-e4m3fn.safetensors"
    "loras/flux/Hyper-FLUX.1-dev-8steps-lora.safetensors"
    "pulid/pulid_flux_v0.9.1.safetensors"
    "insightface"
)

source ${VASTAI_SCRIPTS_DIR}/import-for-schema/_copy.sh