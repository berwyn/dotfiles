# Path shims
if test -d /usr/local/bin
  set -gx PATH /usr/local/bin $PATH
end

if test -d $HOME/.local/bin
  set -gx PATH $HOME/.local/bin $PATH
end

# Go
if test -d $HOME/dev/go
  set -gx GOPATH $HOME/dev/go
  set -gx GOBIN $GOPATH/bin
  set -gx PATH $GOBIN $PATH
end

# Rust
if test -d ~/dev/rust
  set -gx RUST_SRC_PATH ~/dev/rust/src
end

# Android
if test -d ~/android-sdk
  set -gx ANDROID_HOME ~/android-sdk
end

# fundle
fundle plugin 'edc/bass'
fundle plugin 'tuvistavie/fish-fastdir'
fundle plugin 'oh-my-fish/plugin-thefuck'
fundle plugin 'oh-my-fish/plugin-bang-bang'
fundle plugin 'oh-my-fish/plugin-rustup'
fundle plugin 'oh-my-fish/plugin-tmux'
fundle plugin 'oh-my-fish/plugin-await'
fundle plugin 'oh-my-fish/plugin-battery'
fundle plugin 'oh-my-fish/plugin-android-sdk'
fundle plugin 'oh-my-fish/plugin-export'
fundle plugin 'oh-my-fish/plugin-pyenv'
fundle plugin 'oh-my-fish/plugin-rvm'

if [ (uname -s) = 'Darwin' ]
  fundle plugin 'oh-my-fish/plugin-brew'
end

fundle init

# various aliases
alias fucking sudo
alias glass 'rm -rf'
alias goddamnit 'which'
alias cunt vi

# Exa
alias ls exa
alias ll="exa -la --git"

# Docker
alias dc docker-compose
alias dm docker-machine
alias ds docker-swarm

set -gx EDITOR vim

set -x PGHOST "localhost"

# Flutter
if test -d $HOME/dev/flutter/flutter/bin
  set -gx PATH $HOME/dev/flutter/flutter/bin $PATH
end

. ~/.fishmarks/marks.fish

