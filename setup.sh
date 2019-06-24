#!/usr/bin/env bash

say() {
    echo "-----> $@"
}

whisper() {
    echo "---> $@"
}

setup_fish() {
    say "Setting up Fish"
    sudo chsh -s /usr/local/bin/fish $(whoami)
    fish -c "fundle init && fundle install"
}

setup_macos() {
    say "Setting up macOS"
    # Grab brew deps
    whisper "Brewing..."
    brew bundle install

    # Fix key repeat in VS Code
    whisper "Setting up key repeat in VS Code"
    defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
    defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false
}

say "Updating submodules"
git submodule update --init --recursive

# OS-specific setup
case $(uname -a) in
    [Dd]arwin*)
        setup_fish
        setup_macos
        ;;

    [Ll]inux*)
        # TODO: Well, y'know
        ;;
    *)
        >&2 echo "What even is this OS? $(uname -a)"
        exit 1
        ;;
esac

