# Brew shim
set -gx PATH /usr/local/bin $PATH

# Go
set -gx GOPATH $HOME/dev/go
set -gx GOBIN $GOPATH/bin
set -gx PATH $GOBIN $PATH

# Java
set -gx JAVA8_HOME (/usr/libexec/java_home -v 1.8)
set -gx JAVA7_HOME (/usr/libexec/java_home -v 1.7)

set -gx PATH ~/.android-sdk/tools ~/.android-sdk/platform-tools $PATH

# Rust
set -gx RUST_SRC_PATH ~/dev/rust/src

# Fundle
fundle plugin 'edc/bass'
fundle init

function nvm
  bass source (brew --prefix nvm)/nvm.sh --no-use ';' nvm $argv
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
 
# Fire up the shell with Luna!
ponysay -q luna
