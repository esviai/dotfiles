if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" vim-javascript (Vastly improved Javascript indentation and syntax support in Vim.)
" Plug 'ajh17/Spacegray.vim'

Plug 'pangloss/vim-javascript'

" vim-jsx (React JSX syntax highlighting and indenting for vim.)
Plug 'mxw/vim-jsx'

" vim-json (Syntax highlighting for JSON in Vim)
Plug 'leshill/vim-json'

" ale (Asynchronous Lint Engine)
Plug 'w0rp/ale'

" editorconfig-vim (EditorConfig plugin for Vim http://editorconfig.org)
Plug 'editorconfig/editorconfig-vim'

" fugitive.vim: a Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'

" YouCompleteMe (A code-completion engine for Vim http://valloric.github.io/YouCompleteMe/)
Plug 'Valloric/YouCompleteMe'

""Syntastic (Syntax checking hacks for vim)
"Plug 'scrooloose/syntastic'

"" vim-airline
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

" Initialize plugin system
call plug#end()

" Themes
set t_Co=256
let g:solarized_termcolors=256
let g:solarized_termtrans=1

"set leader
let mapleader = ","
let g:mapleader = ","

" Enable filetype plugins
filetype plugin on
filetype indent on
syntax on

" Writing settings
set laststatus=2
set backspace=indent,eol,start
set whichwrap+=<,>,h,l
set textwidth=78
set colorcolumn=+3
" set cursorline
set number
set numberwidth=5
"set ruler
"set cmdheight=2

if has('mouse')
    set mouse=a
endif

" Searching
set ignorecase
set smartcase
"set hlsearch
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Add a bit extra margin to the left
set foldcolumn=1

" Tab settings
set expandtab
set smarttab
set tabstop=4
set shiftwidth=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Two spaces tabs for javascript files
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2
autocmd FileType scss setlocal shiftwidth=2 tabstop=2
autocmd FileType less setlocal shiftwidth=2 tabstop=2

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
" func! DeleteTrailingWS()
"     exe "normal mz"
"     %s/\s\+$//ge
"     exe "normal `z"
" endfunc
" autocmd BufWrite *.py :call DeleteTrailingWS()
" autocmd BufWrite *.coffee :call DeleteTrailingWS()
" autocmd BufWrite *.txt :call DeleteTrailingWS()
"autocmd BufWritePre * %s/\s\+$//e

"" Spacegray.vim
"colorscheme spacegray

" vim-javascript
let g:javascript_plugin_flow = 1

" vim-jsx
let g:jsx_ext_required = 0

" ale
let g:ale_linters = {'jsx': ['eslint','stylelint']}
let g:ale_linters = {'javascript': ['eslint']}
let g:ale_linter_aliases = {'jsx': 'css'}
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

"" vim-airline
"let g:airline_theme='solarized'
"let g:airline_powerline_fonts = 1
"let g:bufferline_echo = 0
""let g:airline-section_b= '%{strftime("%c")}'
""let g:airline-section_y= 'BN: %{bufnr("%")}'

"" syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_javascript_checkers = ['eslint']
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

"" Powerline
"set rtp+=/usr/share/powerline/bindings/vim
"python from powerline.vim import setup as powerline_setup
"python powerline_setup()
"python del powerline_setup
