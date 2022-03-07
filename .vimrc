set nocompatible

" FZF
set rtp+=/usr/local/opt/fzf

" vim-plug
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'powerline/powerline-fonts'
Plug 'vim-airline/vim-airline'
Plug 'kaicataldo/material.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'lifepillar/vim-gruvbox8'
Plug 'preservim/nerdtree'
Plug 'dense-analysis/ale'
Plug 'fatih/vim-go'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-fugitive'

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
set timeoutlen=1000 ttimeoutlen=0 " First is for waiting for keybinds, second is for faster escape
set updatetime=750 " For fast CursorHold event, which I use for ALEHover
set nowrap

" Appearance
set fillchars+=vert:\
set background=dark
colorscheme gruvbox8
let g:gruvbox_italics=1
syntax on
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1

" Vimdiff settings
" if &diff
"     highlight! link DiffText MatchParen
" endif

" Highlight settings
nnoremap <silent><Leader>c :nohlsearch<CR>

" Terminal settings
nnoremap <silent><Leader>T :terminal<CR><C-w>T
nnoremap <silent><Leader>t :terminal<CR>
set termwinsize=12*0 " Smaller terminal

" ALE settings
let g:ale_enabled=1
let g:ale_set_balloons=1
let g:ale_completion_enabled=1
let g:airline#extensions#ale#enabled=1
let g:ale_lsp_show_message_severity='error'

" FZF settings
nnoremap <silent><C-f> :Ag<CR>
nnoremap <silent><Leader>f :Files<CR>
nnoremap <silent><Leader>b :Buffers<CR>
let s:ag_options = ' --skip-vcs-ignores --smart-case '
nnoremap <silent><Leader>ag :Ag <C-R><C-W><CR>

" NERDTree settings
let g:NERDTreeWinSize=45
nnoremap <silent><Leader><Tab> :NERDTreeToggle<CR>

" Goyo settings
highlight StatusLineNC ctermfg=none
let g:goyo_width=120
let g:goyo_linenr=1
nnoremap <silent><Leader>g :Goyo<bar> highlight StatusLineNC ctermfg=none <CR>
nnoremap <silent><Leader>gl :Limelight!!<CR> :Goyo<bar> highlight StatusLineNC ctermfg=none <CR>

" Limelight settings
let g:limelight_conceal_ctermfg=8
nnoremap <silent><Leader>l :Limelight!!<CR>

" Git Fugitive settings
set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P

" vim-go Debugger settings
" Fix the linting marks so that they play nicely with ale
" Starts the debugger regularly and for test files
" nnoremap <Leader>d :GoDebug
