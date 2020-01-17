# dotfiles
A collection of my dotfiles.

## OS
* Manjaro 18.1.0 (KDE)
* WSL2 (Ubuntu)

## Terminal
Konsole, wsltty, and iterm2 with [nord](https://www.nordtheme.com/ports) theme.

## Font
[Space Mono](https://github.com/googlefonts/spacemono)

## Languages
* node.js (Mainly use it for backend stuff and React in the frontend)
* go (For fun)
* ReasonML (Currently playing with it)

## Shell
zsh with zprezto

## Code Searching Tool
I am using [ripgrep](https://github.com/BurntSushi/ripgrep) with fzf, both for the shell and in vim.

## .vimrc
neovim v0.5.0-dev (neovim nightly)
Theme: [nord](https://github.com/arcticicestudio/nord-vim) and [night-owl](https://github.com/haishanh/night-owl.vim)

Plugins: 
* vim-polyglot
* vim-fugitive
* ale
* fzf
* nerdtree
* nerdtree-git-plugin
* emmet-vim
* vim-surround
* auto-pairs
* nerdcommenter
* vim-go
* vim-airline
* vim-airline-themes
* indentLine
* coc

**Installation of python3, node.js, go, reasonml and its language server, and ripgrep is required before installing the plugins.**

Notes: 
With this config, I installed several [coc extensions](https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions), such as eslint, prettier, tsserver, tslint, tslint-plugin, css, json, and [reason language server](https://github.com/jaredly/reason-language-server).
> Since I'm currently using neovim, so the available .vimrc doesn't represent my setup anymore. Yet, it's still valid and very much functioning. I'm keeping it here, in case someone wants to have a look at it (or for when I change back to vim in the future)

## .tmux-conf
tmux v3.0a
Functions:
* remap prefix from 'C-b' to 'C-a'
* vi mode copy paste
* mouse functionality

To have italized font and working home-end key in tmux: [source](https://medium.com/@dubistkomisch/how-to-actually-get-italics-and-true-colour-to-work-in-iterm-tmux-vim-9ebe55ebc2be)
1. Create xterm-256color-italic.terminfo
2. Create tmux-256color.terminfo
3. Install them
```
tic -x xterm-256color-italic.terminfo
tic -x tmux-256color.terminfo
```

## Node version manager
Currently using [n](https://github.com/tj/n)


## Additional stuff to do
- Enable native notifications in Chrome: chrome://flags/#enable-native-notifications
- Add xmodmap.sh to startup application (if remap keys is needed)

## Troubleshoot
### Can't login to wifi with captive portal [source](https://blog.ham1.co.uk/2016/02/06/cannot-sign-in-using-hotel-wifi-on-linux-ubuntu-mint/)
```
sudo dhclient -r
```
### ENOSPC: System limit for number of file watchers reached [source](https://github.com/guard/listen/wiki/Increasing-the-amount-of-inotify-watchers#the-technical-details)
```
echo fs.inotify.max_user_watches=524288 | sudo tee /etc/sysctl.d/40-max-user-watches.conf && sudo sysctl --system
```

## To Do
* Create a bash script to install all
