# dotfiles
A very simple dotfiles from  someone who is still learning vim and tmux the hard way.

## .vimrc
Theme: night owl

## .tmux-conf
Functions:
- remap prefix from 'C-b' to 'C-a'
- vi mode copy paste

To make italized and working home-end key: [source](https://medium.com/@dubistkomisch/how-to-actually-get-italics-and-true-colour-to-work-in-iterm-tmux-vim-9ebe55ebc2be)
1. Create xterm-256color-italic.terminfo
2. Create tmux-256color.terminfo
3. Install them
```
tic -x xterm-256color-italic.terminfo
tic -x tmux-256color.terminfo
```
