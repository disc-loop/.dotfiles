set nocompatible

" FZF
set rtp+=/usr/local/opt/fzf

" vim-plug
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'powerline/powerline-fonts'
Plug 'vim-airline/vim-airline'
Plug 'lifepillar/vim-gruvbox8'
Plug 'preservim/nerdtree'
Plug 'dense-analysis/ale'
Plug 'fatih/vim-go'
Plug 'pangloss/vim-javascript'
Plug 'arcticicestudio/nord-vim'

call plug#end()

" Indentation settings
filetype plugin indent on
set ts=2 sw=2 expandtab " Sets tab and indentation as spaces

" Basic settings
set backspace=indent,eol,start
set ruler
set number relativenumber
set incsearch
set ignorecase
set cursorline
set wrapscan
set autoindent
set hidden
set showmode
set showcmd
set ttyfast
set lazyredraw
set splitbelow
set splitright
set mouse=a
set ttymouse=xterm2
let mapleader=","

" Appearance
set background=dark
colorscheme gruvbox8
let g:gruvbox_italics=1
syntax on
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" Fix this mess
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.colnr = ' ㏇:'
let g:airline_symbols.colnr = ' ℅:'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = ' ␊:'
let g:airline_symbols.linenr = ' ␤:'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.colnr = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '  '
let g:airline_symbols.maxlinenr = ' ☰ '
let g:airline_symbols.dirty='⚡'

" FZF settings
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <Leader>f :Ag<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
let s:ag_options = ' --skip-vcs-ignores --smart-case '

" NERDTree settings
nnoremap <C-n> :NERDTreeToggle<CR>
let g:NERDTreeWinSize=45

" Terminal settings
" Creates terminal in new tab
nnoremap <silent> <Leader>t :terminal<CR><C-w>T
set termwinsize=12*0 " Uncomment for small terminal

" ALE settings
let g:ale_enabled=1
let g:ale_set_balloons=1
let g:ale_completion_enabled=1
