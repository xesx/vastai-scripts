#!/bin/bash
rclone copy -P ydisk:shared/comfyui/models/diffusion_models/flux1-fill-dev-FP8.safetensors /workspace/ComfyUI/models/diffusion_models/
rclone copy -P ydisk:shared/comfyui/models/clip/clip_l.safetensors /workspace/ComfyUI/models/clip/
rclone copy -P ydisk:shared/comfyui/models/clip/t5-v1_1-xxl-encoder-Q4_K_S.gguf /workspace/ComfyUI/models/clip/