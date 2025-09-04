#!/bin/bash

#source /venv/main/bin/activate
#COMFYUI_DIR=${WORKSPACE}/ComfyUI

RCLONE_CONFIG_DIR="${HOME}/.config/rclone"
RCLONE_CONFIG_FILE="${RCLONE_CONFIG_DIR}/rclone.conf"

git clone https://github.com/xesx/vastai-scripts.git
git clone https://github.com/xesx/vateco.git

# Импортируем секреты из Infisical
source ./vastai-scripts/import-secrets.sh

# Packages are installed after nodes so we can fix them...

APT_PACKAGES=(
)

# Make rclone config
mkdir -p "${RCLONE_CONFIG_DIR}"

cat > "${RCLONE_CONFIG_FILE}" <<EOF
[ydisk]
type = yandex
token = {"access_token":"$YANDEX_DISK_ACCESS_TOKEN","token_type":"OAuth","refresh_token":"$YANDEX_DISK_REFRESH_TOKEN","expiry":"2025-04-15T14:11:36.588423+03:00"}
EOF

# Запуск rclone API-сервера без авторизации на порту 5572
nohup rclone rcd --rc-addr=:15572 --rc-no-auth > /var/log/rclone.log 2>&1 &

### DO NOT EDIT BELOW HERE UNLESS YOU KNOW WHAT YOU ARE DOING ###

function provisioning_start() {
    printf "\n##############################################\n#                                            #\n#          Provisioning container            #\n#                                            #\n#         This will take some time           #\n#                                            #\n# Your container will be ready on completion #\n#                                            #\n##############################################\n\n"

    provisioning_get_apt_packages

#    rclone config reconnect ydisk:
#    rclone copy -P ydisk:comfyui-link-source/user /workspace/ComfyUI/user

    deploy_app_cloud_api

    printf "\nProvisioning complete:  Application will start now\n\n"
}

function provisioning_get_apt_packages() {
    if [[ -n $APT_PACKAGES ]]; then
            sudo apt install "${APT_PACKAGES[@]}"
    fi
}

deploy_app_cloud_api() {
    cd ${WORKSPACE}/vateco

    which node >> /var/log/provisioning.log 2>&1
    which npm >> /var/log/provisioning.log 2>&1
    # Установка зависимостей
    npm install

    # Сборка проекта
    npm run build

    # Запуск приложения cloud-app-api
    npm run start:cloud-api:prod

    cd ${WORKSPACE}
}

provisioning_start
