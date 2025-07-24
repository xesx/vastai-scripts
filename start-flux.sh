#!/bin/bash

source /venv/main/bin/activate
COMFYUI_DIR=${WORKSPACE}/ComfyUI

RCLONE_CONFIG_DIR="${HOME}/.config/rclone"
RCLONE_CONFIG_FILE="${RCLONE_CONFIG_DIR}/rclone.conf"

# Packages are installed after nodes so we can fix them...

APT_PACKAGES=(
    "fzf"
)

PIP_PACKAGES=(
    #"package-1"
    #"package-2"
)

NODES=(
    "https://github.com/ltdrdata/ComfyUI-Manager"
    "https://github.com/crystian/ComfyUI-Crystools"
    "https://github.com/cubiq/ComfyUI_essentials"
    "https://github.com/twri/sdxl_prompt_styler"
    "https://github.com/GavChap/ComfyUI-SD3LatentSelectRes"
)

# Make rclone config
mkdir -p "${RCLONE_CONFIG_DIR}"

cat > "${RCLONE_CONFIG_FILE}" <<EOF
[ydisk]
type = yandex
token = {"access_token":"$YANDEX_DISK_ACCESS_TOKEN","token_type":"OAuth","refresh_token":"$YANDEX_DISK_REFRESH_TOKEN","expiry":"2025-04-15T14:11:36.588423+03:00"}
EOF


git clone https://github.com/xesx/vastai-scripts.git

### DO NOT EDIT BELOW HERE UNLESS YOU KNOW WHAT YOU ARE DOING ###

function provisioning_start() {
    provisioning_print_header
    provisioning_get_apt_packages
    provisioning_get_nodes
    provisioning_get_pip_packages
    provisioning_print_end

    rclone config reconnect ydisk:
    rclone copy -P ydisk:comfyui-link-source/user /workspace/ComfyUI/user
}

function provisioning_get_apt_packages() {
    if [[ -n $APT_PACKAGES ]]; then
            sudo apt install "${APT_PACKAGES[@]}"
    fi
}

function provisioning_get_pip_packages() {
    if [[ -n $PIP_PACKAGES ]]; then
            pip install --no-cache-dir "${PIP_PACKAGES[@]}"
    fi
}

function provisioning_get_nodes() {
    for repo in "${NODES[@]}"; do
        dir="${repo##*/}"
        path="${COMFYUI_DIR}/custom_nodes/${dir}"
        requirements="${path}/requirements.txt"
        if [[ -d $path ]]; then
            if [[ ${AUTO_UPDATE,,} != "false" ]]; then
                printf "Updating node: %s...\n" "${repo}"
                ( cd "$path" && git pull )
                if [[ -e $requirements ]]; then
                   pip install --no-cache-dir -r "$requirements"
                fi
            fi
        else
            printf "Downloading node: %s...\n" "${repo}"
            git clone "${repo}" "${path}" --recursive
            if [[ -e $requirements ]]; then
                pip install --no-cache-dir -r "${requirements}"
            fi
        fi
    done
}

function provisioning_print_header() {
    printf "\n##############################################\n#                                            #\n#          Provisioning container            #\n#                                            #\n#         This will take some time           #\n#                                            #\n# Your container will be ready on completion #\n#                                            #\n##############################################\n\n"
}

function provisioning_print_end() {
    printf "\nProvisioning complete:  Application will start now\n\n"
}

provisioning_start
