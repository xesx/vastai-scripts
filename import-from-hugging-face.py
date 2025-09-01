# pip install huggingface_hub
# huggingface-cli login
# huggingface-cli download bert-base-uncased --local-dir ./bert-base

from huggingface_hub import snapshot_download

# Пример: скачиваем модель Llama-3 от Meta (если доступна)
# snapshot_download(repo_id="hfmaster/models-moved", local_dir=".")

# # Правильный repo_id — только репозиторий
# repo_id = "Comfy-Org/HiDream-I1_ComfyUI"

# # Путь к нужному файлу (или папке), который хочешь скачать
# file_path = "split_files/diffusion_models/hidream_e1_1_bf16.safetensors"

repo_id = "hfmaster/models-moved"
file_path = "HiDream"

# Скачиваем только нужный файл
snapshot_download(
    repo_id=repo_id,
    allow_patterns=file_path,  # скачаем только этот файл
    local_dir=".",             # куда сохранить
    repo_type="model"          # указываем тип репозитория (по умолчанию)
)