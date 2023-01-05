# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# changing ulimit. Source: https://fantashit.com/building-on-macos-big-sur/
ulimit -S -n 4096

# zsh history
export HISTSIZE=100000
export SAVEHIST=$HISTSIZE
# Write the history file in the ":start:elapsed;command" format
setopt EXTENDED_HISTORY
# Expire duplicate entries first when trimming history
setopt HIST_EXPIRE_DUPS_FIRST

# cocoapods
# export GEM_HOME=$HOME/.gem
# export PATH=$PATH:$HOME/.gem/bin

# custom scripts
export PATH="$PATH:$HOME/.local/bin"

# flutter
# export PATH="$PATH:$HOME/flutter/bin"

# go
export GOROOT=/usr/local/go
export GOPATH="$HOME/go"
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# goenv
# export GOENV_ROOT="$HOME/.goenv"
# export PATH="$GOENV_ROOT/bin:$PATH"
# eval "$(goenv init -)"
# export PATH="$GOROOT/bin:$PATH"
# export PATH="$PATH:$GOPATH/bin"

#php
export PATH="/usr/local/opt/php@7.4/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/php@7.4/lib"
export CPPFLAGS="-I/usr/local/opt/php@7.4/include"

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

# fzf
# mac
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# # ubuntu
# source /usr/share/doc/fzf/examples/key-bindings.zsh
# source /usr/share/doc/fzf/examples/completion.zsh
# default search command
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# kubecolor
# get zsh complete kubectl
# this one makes terminal slow (try to figure out why!)
# source <(kubectl completion zsh)
# alias kubectl=kubecolor
# make completion work with kubecolor
# compdef kubecolor=kubectl

# Editor
export EDITOR=/usr/local/bin/nvim

# Aliases
alias nst="npm start"
alias nrw="npm run watch"
alias vim="nvim"
alias reww="rg --files | tree --fromfile"
# k8s aliases
# https://github.com/hidetatz/kubecolor
alias k=kubectl
alias kg="k get"
alias kgy="k get -o yaml --plain"
alias kgp="k get pods -o wide"
alias kgpy="k get pods -o yaml --plain"
alias kgs="k get svc -o wide"
alias kgsy="k get svc -o yaml --plain"
alias kga="k get all -o wide"
alias kgr="k get replicaset -o wide"
alias kgry="k get replicaset -o yaml --plain"
alias kgn="k get namespaces -o wide"
alias kgny="k get namespaces -o yaml --plain"
alias kgd="k get deploy -o wide"
alias kgdy="k get deploy -o yaml --plain"
alias kc="kubectx"
alias st="stern -E istio-proxy -s 5m"

# Functions
function mkdcd {
  [[ -n "$1" ]] && mkdir -p "$1" && builtin cd "$1"
}

# direnv
# https://direnv.net/
eval "$(direnv hook zsh)"

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

