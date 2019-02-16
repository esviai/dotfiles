"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Inspired by: 
"       Amir Salihefendic
"       http://amix.dk - amix@amix.dk
"
" Modifier:
"       Shabrina V. Inmas
"       http://esviai.com
"
" Sections:
"    -> Vim Plug
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim Plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Install Vim Plug if it doesn't exists
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" vim-polyglot (A collection of language packs for Vim.)
Plug 'sheerun/vim-polyglot'

" vim-fugitive (The best Git wrapper of all time.)
Plug 'tpope/vim-fugitive'

" vim-airline (Lean & mean status/tabline for vim that's light as air.)
Plug 'bling/vim-airline'

" vim airline themes (The official theme repository for vim-airline.)
Plug 'vim-airline/vim-airline-themes'

" tern_for_vim (This is a Vim plugin that provides Tern-based JavaScript editing support.)
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }

" YouCompleteMe (A code-completion engine for Vim.)
Plug 'Valloric/YouCompleteMe'

" emmet-vim
Plug 'mattn/emmet-vim'

" ale (Asynchronous Lint Engine)
Plug 'w0rp/ale'

" nerdtree (A tree explorer plugin for vim.)
Plug 'scrooloose/nerdtree'

" nerdtree-git-plugin (A plugin of NERDTree showing git status flags. Works with the LATEST version of NERDTree.)
Plug 'Xuyuanp/nerdtree-git-plugin'

" vim-surround (Surround.vim is all about surroundings: parentheses, brackets, quotes, XML tags, and more.)
Plug 'tpope/vim-surround'

" junegunn/fzf.vim (Things you can do with fzf and Vim.)
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" jiangmiao/auto-pairs (Insert or delete brackets, parens, quotes in pair.)
Plug 'jiangmiao/auto-pairs'

" Yggdroot/indentLine (Displaying thin vertical lines at each indentation level for code indented with spaces.)
Plug 'Yggdroot/indentLine'

" fatih/vim-go (Go development plugin for Vim)
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

"Vim plugin for intensely orgasmic commenting
Plug 'scrooloose/nerdcommenter'

" jbgutierrez/vim-better-comments (Easily highlight human-friendly comments in your code!)
" Plug 'jbgutierrez/vim-better-comments'

" Wakatime (Vim plugin for automatic time tracking and metrics generated from your programming activity.)
" Plug 'wakatime/vim-wakatime'

" Themes
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'whatyouhide/vim-gotham'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'connorholyday/vim-snazzy'
Plug 'junegunn/seoul256.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'trusktr/seti.vim'
Plug 'haishanh/night-owl.vim'

" Initialize plugin system
call plug#end()

" ale
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'
let g:ale_linters = {'javascript': ['eslint', 'jshint'], 'jsx': ['eslint','stylelint']}
let g:ale_linter_aliases = {'jsx': ['css', 'javascript']}
let g:ale_fixers = {'javascript': ['prettier', 'eslint']}
"let g:ale_lint_on_text_changed = 'never'
"let g:ale_lint_on_enter = 0
"let g:ale_open_list = 1
"let g:ale_javascript_eslint_use_global = 1
let g:ale_list_window_size = 5
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" YoucompleteMe
" let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1

"" vim-airline
set laststatus=2
let g:airline_theme= 'night_owl'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep = '▶'
  let g:airline_left_alt_sep = '»'
  let g:airline_right_sep = '◀'
  let g:airline_right_alt_sep = '«'
  let g:airline#extensions#branch#prefix = '⤴' "➔, ➥, ⎇
  let g:airline#extensions#readonly#symbol = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol = 'ρ'
  let g:airline_symbols.linenr = '␊'
  let g:airline_symbols.branch = '⎇'
  let g:airline_symbols.paste = 'ρ'
  let g:airline_symbols.paste = 'Þ'
  let g:airline_symbols.paste = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif

" nerdtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeAutoDeleteBuffer = 1

" indentLine
let g:indentLine_char = '┆'
" let g:indentLine_setColors = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" Change leader to ,
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" These are things that I mistype and want ignored.
nmap Q  <silent>
nmap q: <silent>
" nmap K  <silent>

" fzf.vim
nmap ; :Buffers<cr>
nmap <Leader>r :History<cr>
nmap <Leader>f :Files<cr>
nmap <Leader>F :GFiles<cr>
nmap <Leader>a :Ag<cr>
nmap <Leader>li :Lines<cr>
nmap <Leader>lo :BLines<cr>

" Use ag over grep
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif
" https://robots.thoughtbot.com/faster-grepping-in-vim
" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" ale
nmap <Leader>af :ALEFix<cr>

" nerdtree
nmap <Leader>nt :NERDTree<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mouse
if has('mouse')
    set mouse=a
endif

" Set 7 lines to the cursor - when moving vertically using j/k
" set so=7

" Turn on the WiLd menu
set wildmenu

" List all options and complete
set wildmode=list:longest,full

" Ignore compiled files
set wildignore=*.o,*~,*.pyc,.git,node_modules
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"Always show current position and line number
set ruler
set number
set numberwidth=5

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
" set hlsearch
" map F3 to toggle search highlighting
nnoremap <F3> :set hlsearch!<CR>

" Makes search act like search in modern browsers
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

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" Add a bit extra margin to the left
set foldcolumn=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax on

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Theme
set background=dark
" colorscheme molokai
" let g:rehash256 = 1
" let g:molokai_original = 1
" colorscheme hybrid_reverse
colorscheme night-owl
let g:enable_bold_font = 1
let g:enable_italic_font = 1

" Set extra options when running in GUI mode
" if has("gui_running")
"     set term = xterm
" endif
" 
if (has("termguicolors"))
  set termguicolors
endif

" Enable 256 colors palette in Gnome Terminal
" Disable Background Color Erase (BCE) so that color schemes
" render properly when inside 256-color tmux and GNU screen.
" see also http://snk.tuxfamily.org/log/vim-256color-bce.html
if !has('gui_running')
  if $TERM == "xterm-256color" || $TERM == "screen-256color" || $TERM == "tmux-256color" || $COLORTERM == "gnome-terminal"
    set t_Co=256
  elseif has("terminfo")
    colorscheme default
    set t_Co=8
    set t_Sf=[3%p1%dm
    set t_Sb=[4%p1%dm
  else
    colorscheme default
    set t_Co=8
    set t_Sf=[3%dm
    set t_Sb=[4%dm
  endif
  " Disable Background Color Erase when within tmux - https://stackoverflow.com/q/6427650/102704
  if &term =~ '256color'
    set t_ut=
  endif
endif

highlight Comment gui=italic cterm=italic
highlight htmlArg gui=italic cterm=italic
highlight Type gui=italic cterm=italic
highlight Constant gui=italic cterm=italic
highlight jsStorageClass gui=italic cterm=italic


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Stop auto commenting line
au FileType * set fo-=c fo-=r fo-=o

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Two spaces tabs for javascript files
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2
autocmd FileType ejs setlocal shiftwidth=2 tabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2

" au BufRead,BufNewFile,BufEnter /home/dev/Documents/Codes/* setlocal ts=4 sw=4

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Natural splitting
set splitbelow
set splitright

" Return to the last edited file
nmap <C-e> :e#<CR>

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
" Disabling this since <C-j> and <C-k> has been mapped to ale
"map <C-j> <C-W>j
"map <C-k> <C-W>k
"map <C-h> <C-W>h
"map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

" Move between buffers
map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext 

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
    nmap <D-j> <M-j>
    nmap <D-k> <M-k>
    vmap <D-j> <M-j>
    vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

" Load specifics config to this host
if filereadable(expand("~/.vimlocal"))
  source ~/.vimlocal
endif
