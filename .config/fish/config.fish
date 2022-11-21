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

# Pyenv, because the OMF plugin is bad
if test -d ~/.pyenv
  set -gx PYENV_ROOT ~/.pyenv
end

if test -d ~/dev/go
  set -gx GOPATH ~/dev/go
  set -gx PATH ~/dev/go/bin $PATH
end

# fundle
fundle plugin 'edc/bass'
fundle plugin 'tuvistavie/fish-fastdir'
fundle plugin 'oh-my-fish/plugin-thefuck'
fundle plugin 'oh-my-fish/plugin-bang-bang'
fundle plugin 'oh-my-fish/plugin-rustup'
fundle plugin 'oh-my-fish/plugin-tmux'
fundle plugin 'oh-my-fish/plugin-pyenv'
fundle plugin 'oh-my-fish/plugin-rvm'
fundle plugin 'oh-my-fish/plugin-direnv'

if [ (uname -s) = 'Darwin' ]
  fundle plugin 'oh-my-fish/plugin-brew'
end

fundle init

# Replace old, painful tools with modern ones 🦀
if [ (uname -s) = 'Darwin' ]
    source $HOME/Library/Preferences/org.dystroy.broot/launcher/fish/br
end

alias ls="exa --grid --classify"
alias ll="exa -bg --long --classify --header --git"
alias tree="exa --tree"
alias find="fd"

# Docker
alias dc docker-compose
alias dm docker-machine
alias ds docker-swarm

# Misc
alias klar clear

# Pyenv
status --is-interactive; and source (pyenv init -|psub)
# rbenv
status --is-interactive; and source (rbenv init -|psub)

set -gx EDITOR vim

set -x PGHOST "localhost"

# Flutter
if test -d $HOME/dev/flutter/flutter/bin
  set -gx PATH $HOME/dev/flutter/flutter/bin $PATH
end

# Krew
if test -d $HOME/.krew
  set -gx PATH $HOME/.krew/bin $PATH
end

status --is-interactive; and . (jump shell | psub)

if test -d ~/.fishmarks
  . ~/.fishmarks/marks.fish
end

. (which env_parallel.fish)

set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH
