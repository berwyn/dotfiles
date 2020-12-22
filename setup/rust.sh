#!/usr/bin/env bash

set -euo pipefail

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
        bat \
        broot \
        bottom \
        delta \
        du-dust \
        exa \
        fd-find \
        hx \
        hyperfine \
        kondo \
        procs \
        ripgrep \
        sd \
        skim \
        starship \
        tealdeer \
        tokei
}

