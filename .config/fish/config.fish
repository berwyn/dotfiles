# Brew shim
set -gx PATH /usr/local/bin /usr/local/sbin $PATH

# Go
set -gx GOPATH ~berwyn/dev/go
set -gx GOBIN $GOPATH/bin
set -gx PATH $GOBIN $PATH

# Java
set -gx JAVA8_HOME (/usr/libexec/java_home -v 1.8)
set -gx JAVA7_HOME (/usr/libexec/java_home -v 1.7)

set -gx PATH ~/.android-sdk/tools ~/.android-sdk/platform-tools $PATH

# Rust
set -gx RUST_SRC_PATH ~/dev/rust/src

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

function setdocker -d "Sets boot2docker envvars"
  for line in (boot2docker shellinit)
    eval $line
  end
end

# VSC shortcut
function code
  set -lx VSCODE_CWD (pwd)
  open -n -b "com.microsoft.VSCode" --args $argv
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

# Oh My Fish! without their stupid prompt
set fish_plugin_home $HOME/.oh-my-fish
set fish_plugins rvm sublime brew bundler node localhost rails rake
#for plugin in fish_plugins
#  set -l load_path "plugins/$plugin/$plugin.load"
#  set -l complete_path "plugins/$plugin/completions"
# 
#  if test -e $fish_plugin_home/plugins/$plugin
#    set fish_function_path $fish_function_path $fish_plugin_home/plugins/$plugin
#  end
# 
#  if test -d $fish_plugin_home/$complete_path
#    set fish_complete_path $fish_complete_path $fish_path/$complete_path
#  end
# 
#  if test -e $fish_plugin_home/$load_path
#    . $fish_plugin_home/$load_path
#  end
#end
 
# nvlc
alias nvlc "~/Applications/VLC.app/Contents/MacOS/VLC --intf ncurses"

set -gx EDITOR code
 
# Fire up the shell with Luna!
ponysay -q luna
