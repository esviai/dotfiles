# dotfiles
A collection of my dotfiles.

## OS
Pop OS (based on Ubuntu 18.10)

## shell
zsh with zprezto
I prefer using Ag with fzf, thus installation of [Ag](https://github.com/ggreer/the_silver_searcher) is required.

## .vimrc
vim v8.1
Theme: night owl

Plugins: 
- vim-polyglot
- vim-fugitive
- ale
- fzf
- nerdtree
- nerdtree-git-plugin
- emmet-vim
- vim-surround
- auto-pairs
- nerdcommenter
- tern_for_vim
- vim-go
- YouCompleteMe
- vim-airline
- vim-airline-themes
- indentLine

Installation of python3, node.js, and go is required before installing the plugins.

Notes:
If you'd like to use YouCompleteMe with different language support, you may make adjustment on the post-hook line.
For instance if you need java and rust support instead of js and go, then you may change the line to:
```
Plug 'Valloric/YouCompleteMe', { 'do': 'python3 install.py --rust-completer --java-completer'  }
```

## .tmux-conf
tmux v2.8
Functions:
- remap prefix from 'C-b' to 'C-a'
- vi mode copy paste

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
