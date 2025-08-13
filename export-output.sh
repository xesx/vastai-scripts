#!/bin/bash

# Формируем имя папки назначения с текущей датой и временем
DEST_FOLDER="output_$(date +'%Y-%m-%d-%H-%M')"

# Копируем файлы на Яндекс.Диск
rclone copy /workspace/ComfyUI/output ydisk:output/"$DEST_FOLDER" --progress

# Если копирование прошло успешно (код возврата 0), очищаем папку
if [ $? -eq 0 ]; then
    rm -rf /workspace/ComfyUI/output/*
    echo "✅ Копирование завершено. Папка очищена."
else
    echo "❌ Ошибка копирования. Папка не была очищена."
fi
