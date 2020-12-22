# Rust replacements
alias ls='exa'
alias ll='exa -lah'
alias find='fd'
alias grep='rg'
alias du='dust'
alias cat='bat'
alias time='hyperfine'
alias sed='sd'
alias clocl='tokei'
alias top='btm'
alias htop='btm'
alias ps='procs'

if command -v brew 1> /dev/null; then
    source $(brew --prefix asdf)/asdf.sh
fi

function gpu() {
    if [[ -d .git ]]; then
        git push -u origin $(git rev-parse --abbrev-ref HEAD)
    else
        echo "Not a git repo"
    fi
}

if [[ -d "${HOME}/.local/bin" ]]; then
    export PATH="${HOME}/.local/bin:${PATH}"
fi

autoload -Uz compinit && compinit -y

export GPG_TTY=$(tty)

eval "$(starship init zsh)"

