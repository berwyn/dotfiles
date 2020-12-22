#!/usr/bin/env bash

set -euo pipefail

update_system_packages() {
    if command -v apt-get; then
        sudo apt-get update && sudo apt-get upgrade -yqq 2>&1
    fi
}

install_baseline_packages() {
    if command -v apt-get; then
        sudo apt-get install -yqq \
            build-essential pkg-config \
            python3 python-is-python3 \
            llvm llvm-dev clang \
            libssl-dev
    fi
}

link_config_files() {
    DIRECTORIES=(.config .vim)
    for directory in ${DIRECTORIES[*]}; do
        if [ ! -L "${HOME}/${directory}" ]; then
            if [ -d "${HOME}/${directory}" ]; then
                murmur "Found existing ${directory} directory, removing..."
                rm -r ${HOME}/${directory}
            fi
        fi

        murmur "Linking ${directory}"
        ln -sf ${HOME}/dev/berwyn/dotfiles/${directory} ${HOME}/${directory}
    done

    FILES=(.vim .vimrc .tmux.conf .bashrc)
    for file in ${FILES[*]}; do
        if [ ! -L "${HOME}/${file}" ]; then
            if [ -f "${HOME}/${file}" ]; then
                murmur "Found existing ${file}, removing..."
                rm ${HOME}/${file}
            fi
        fi

        murmur "Linking ${file}"
        ln -sf ${HOME}/dev/berwyn/dotfiles/${file} ${HOME}/${file}
    done
}
