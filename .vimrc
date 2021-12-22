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

call plug#end()

" Indentation settings
filetype plugin indent on
set ts=2 sw=2 expandtab " Sets tab and indentation as spaces

" Basic settings
let mapleader=","
set backspace=indent,eol,start
set ruler
set number relativenumber
set hlsearch
set incsearch
set ignorecase
set cursorline
set wrapscan
set autoindent
set smartindent
set hidden
set showmode
set showcmd
set ttyfast
set lazyredraw
set splitbelow
set splitright
set mouse=a
set ttymouse=xterm2
set timeoutlen=1000 ttimeoutlen=0

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
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
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
let g:airline_symbols.maxlinenr = ' '
let g:airline_symbols.dirty='⚡'

" Clear search highlighting
nnoremap <silent> <Leader>c :nohlsearch<CR>

" ALE settings
let g:ale_enabled=1
let g:ale_set_balloons=1
let g:ale_completion_enabled=1

" FZF settings
nnoremap <silent> <C-f> :Ag<CR>
nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
let s:ag_options = ' --skip-vcs-ignores --smart-case '
nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>

" NERDTree settings
nnoremap <C-n> :NERDTreeToggle<CR>
let g:NERDTreeWinSize=45

" Terminal settings
nnoremap <silent> <Leader>T :terminal<CR><C-w>T
nnoremap <silent> <Leader>t :terminal<CR>
set termwinsize=12*0 " Smaller terminal

" vim-go Debugger settings
" Starts the debugger regularly and for test files
" nnoremap <Leader>d :GoDebug
