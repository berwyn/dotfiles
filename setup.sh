#!/usr/bin/env bash

echo "Updating submodules"
git submodule update --init --recursive

# Install all our apps
echo "Brewing"
brew bundle

# Node sucks, give it special attention
echo "Installing node"
npm i -g n
HAS_LATEST=n ls | grep $(n --latest)
if [[ -z $HAS_LATEST ]]; then
    n latest
fi

# Setup YouCompleteMe
echo "Setting up YCM"
pushd . 2>&1
cd .vim/bundle/YouCompleteMe
./install.py \
    --clang-completer \
    --omnisharp-completer \
    --tern-completer \
    --racer-completer \
    --gocode-completer
popd
