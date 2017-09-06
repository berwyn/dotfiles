# Brew shim
set -gx PATH /usr/local/bin $PATH

# Go
if test -d $HOME/dev/go
  set -gx GOPATH $HOME/dev/go
  set -gx GOBIN $GOPATH/bin
  set -gx PATH $GOBIN $PATH
end

# Android
if test -d ~/.android-sdk
  set -gx PATH ~/.android-sdk/tools ~/.android-sdk/platform-tools $PATH
end

# Rust
if test -d ~/dev/rust
  set -gx RUST_SRC_PATH ~/dev/rust/src
end

# Funcs
function reload -d 'Reloads fish'
  clear
  source ~/.config/fish/config.fish
end

function !! -d 'Repeats the last command'
  eval $history[1]
end

function sudo
  if test "$argv" = !!
    eval command sudo $history[1]
  else
    command sudo $argv
  end
end

# Doge!

alias wow 'git status'
alias such git
alias very git
alias much git
alias so git
alias many git

# various aliases
alias fucking sudo
alias glass 'rm -rf'
alias dafuq 'find . -name'
alias goddamnit 'which'
alias shit 'cd ..'
alias piss 'ls -lah'
alias cunt vi

# nvlc
alias nvlc "~/Applications/VLC.app/Contents/MacOS/VLC --intf ncurses"

set -gx EDITOR code

# Platterz
rvm default
set -x PGHOST "localhost"

