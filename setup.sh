#!/usr/bin/env bash

set -euxo pipefail

TOP_LEVEL=$(cd $(dirname ${0}) && pwd)
source ${TOP_LEVEL}/setup/util.sh

setup_fish() {
    say "Setting up Fish"
    sudo chsh -s /usr/local/bin/fish $(whoami)
    fish -C "fundle init && fundle install"
}

setup_macos() {
    say "Setting up macOS"
    whisper "Loading util scripts"
    source ${TOP_LEVEL}/setup/util.sh
    whisper "Loading Rust scripts"
    source ${TOP_LEVEL}/setup/rust.sh

    whisper "Disabling Gatekeeper"
    sudo spctl --master-disable

    whisper "Setting symlinks"
    FILES=(".tmux.conf" ".vimrc" ".vim" ".zshrc")
    for FILE in ${FILES[*]}; do
        ln -Fihsv "$PWD/$FILE" "$HOME/$FILE"
    done

    # macOS' `ln` behaves weird, so
    ln -Fihsv "$PWD/.config" $HOME
    # Specifically, trying to link to `$HOME/.config` creates `$HOME/.config/.config`

    whisper "Setting up Homebrew"
    if ! command -v brew >/dev/null 2>&1; then
        whisper "Homebrew not found, installing..."
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    # Grab brew deps
    whisper "Brewing..."
    brew bundle install

    # Fix key repeat in VS Code
    whisper "Setting up key repeat in VS Code"
    defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
    defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false

    whisper "Setting Dock preferences"
    # Set the Dock on the right side
    defaults write com.apple.dock pinning -string end
    defaults write com.apple.dock orientation -string right
    # Autohide
    defaults write com.apple.dock autohide -bool true
    # Magnification size
    defaults write com.apple.dock magnification -bool true
    defaults write com.apple.dock largesize -float 128
    # Show hidden apps
    defaults write com.apple.dock showhidden -bool true
    sudo killall Dock

    whisper "Fixing trackpad"
    defaults write com.apple.swipescrolldirection -bool false
    defaults write com.apple.forceClick -bool true
    killall cfprefsd

    whisper "Setting general macOS preferences"
    defaults write NSGlobalDomain AppleAccentColor 5
    defaults write NSGlobalDomain AppleAquaColorVariant 1
    defaults write NSGlobalDomain AppleInterfaceStyle -string Dark

    whisper "Setting up language preferenes"
    defaults write NSGlobalDomain AppleLanguages -array-add en-CA
    defaults write NSGlobalDomain AppleLanguages -array-add ja-JP
    defaults write NSGlobalDomain NSLinguisticDataAssetsRequested -array-add fr
    defaults write NSGlobalDomain NSLinguisticDataAssetsRequested -array-add fr_CA
    defaults write NSGlobalDomain NSLinguisticDataAssetsRequested -array-add ja
    defaults write NSGlobalDomain NSLinguisticDataAssetsRequested -array-add ja_JP
    defaults write NSGlobalDomain NSLinguisticDataAssetsRequested -array-add de
    defaults write NSGlobalDomain NSLinguisticDataAssetsRequestedByChecker -array-add de

    whisper "Setting timezone"
    sudo systemsetup -settimezone America/Toronto

    whisper "Setting up Rustup"
    install_rustup

    whisper "Installing Cargo packages"
    install_cargo_packages

    whisper "Re-enabling Gatekeeper"
    sudo spctl --master-enable
}

setup_linux() {
    say "Beginning Linux Setup"
    whisper "Loading Linux scripts"
    source ${TOP_LEVEL}/setup/linux.sh
    whisper "Loading Rust scripts"
    source ${TOP_LEVEL}/setup/rust.sh

    whisper "Updating system packages"
    update_system_packages

    whisper "Acquiring baseline packages"
    install_baseline_packages

    whisper "Installing Rustup"
    install_rustup

    whisper "Installing Cargo packages"
    install_cargo_packages

    whisper "Linking config files"
    link_config_files
}

say "Updating submodules"
git submodule update --init --recursive

# OS-specific setup
case $(uname -a) in
    [Dd]arwin*)
        setup_macos
        ;;

    [Ll]inux*)
        setup_linux
        ;;
    *)
        >&2 echo "What even is this OS? $(uname -a)"
        exit 1
        ;;
esac

