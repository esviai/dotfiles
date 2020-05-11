# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Node version manager
# export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# export FZF_DEFAULT_COMMAND='rg --hidden --files'
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Google Cloud SDK
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/dev/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/dev/google-cloud-sdk/path.zsh.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '/Users/dev/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/dev/google-cloud-sdk/completion.zsh.inc'; fi

# aws
# export PATH=~/.local/bin:$PATH

# eb
# export PATH=/home/dev/.ebcli-virtual-env/executables:$PATH

# go
export GOPATH="$HOME/go"
export PATH="$PATH:$(go env GOPATH)/bin"

# Yarn
export PATH=~/.yarn/bin:$PATH

# Editor
export EDITOR=/usr/local/bin/nvim

# Aliases
alias nst="npm start"
alias nrw="npm run watch"
alias vim="nvim"
alias rst="realize start"
# tree, but respecting gitignore || https://www.hardscrabble.net/2019/tree-but-respecting-your-gitignore/
alias trww = rg --hidden --files | tree --fromfile
unalias mysql

# Functions
function mkdcd {
  [[ -n "$1" ]] && mkdir -p "$1" && builtin cd "$1"
}
function note {
  vim ~/Desktop/meeting_notes/meeting_notes.md
}
