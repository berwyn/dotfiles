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

install_rustup() {
    if command -v rustup; then
        murmur 'Found existing Rustup installation'
        rustup update
    else
        murmur 'Installing Rustup'
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \
            | sh -s -- --default-toolchain stable --profile default -y \
            && source ${HOME}/.cargo/env
    fi
}

install_cargo_packages() {
    if ! command -v cargo; then
        if [ -d ${HOME}/.cargo/env ]; then
            source ${HOME}/.cargo/env
        else
            murmur "Cargo isn't where it's supposed to be..."
            exit 1
        fi
    fi
    
    cargo install \
        exa \
        starship \
        fd-find \
        bat \
        broot \
        kondo \
        hx \
        tealdeer
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