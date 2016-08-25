#!/usr/bin/env bash

# Link vim files
ln -s ./.vimrc ~/.vimrc
ln -s ./.vim ~/.vim

# OSX
if [[ $(uname -a) == Darwin* ]]; then
    xcode-select --install

    if [ ! $(command -v brew) ]; then
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    brew install node rust git fish \
        docker docker-compose docker-machine docker-swarm \
        go gradle hub pidcat python python3 tig tmux vim brew-cask

    brew cask install github virtualbox vlc skype java google-chrome \
        visual-studio-code dropbox daisydisk

fi

# Node globals
npm install -g typescript gulp-cli

# Setup YouCompleteMe
pushd .
cd ~/.vim/bundle/YouCompleteMe
./install.py \
    --clang-completer \
    --omnisharp-completer \
    --tern-completer \
    --racer-completer \
    --gocode-completer
popd
