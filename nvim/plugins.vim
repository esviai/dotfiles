call plug#begin('~/.local/share/nvim/plugged')

" junegunn/fzf.vim (Things you can do with fzf and Vim.)
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" ale (Asynchronous Lint Engine)
Plug 'dense-analysis/ale'

" coc.nvim (Intellisense engine for vim8 & neovim, full language server protocol support as VSCode)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" vim-polyglot (A collection of language packs for Vim.)
Plug 'sheerun/vim-polyglot'

" emmet-vim
Plug 'mattn/emmet-vim'

" vim-fugitive (The best Git wrapper of all time.)
Plug 'tpope/vim-fugitive'

" nerdtree (A tree explorer plugin for vim.)
Plug 'scrooloose/nerdtree'

" nerdtree-git-plugin (A plugin of NERDTree showing git status flags. Works with the LATEST version of NERDTree.)
Plug 'Xuyuanp/nerdtree-git-plugin'

" vim-surround (Surround.vim is all about surroundings: parentheses, brackets, quotes, XML tags, and more.)
Plug 'tpope/vim-surround'

" jiangmiao/auto-pairs (Insert or delete brackets, parens, quotes in pair.)
Plug 'jiangmiao/auto-pairs'

"Vim plugin for intensely orgasmic commenting
Plug 'scrooloose/nerdcommenter'

" Yggdroot/indentLine (Displaying thin vertical lines at each indentation level for code indented with spaces.)
Plug 'Yggdroot/indentLine'

" Themes
Plug 'haishanh/night-owl.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'mhartington/oceanic-next'

" vim-airline (Lean & mean status/tabline for vim that's light as air.)
Plug 'bling/vim-airline'

" vim airline themes (The official theme repository for vim-airline.)
Plug 'vim-airline/vim-airline-themes'

" wakatime (Vim plugin for automatic time tracking and metrics generated from your programming activity. )
Plug 'wakatime/vim-wakatime'

call plug#end()
