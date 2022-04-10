" FZF runtime path
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

" Indentation
filetype plugin indent on
set ts=2 sw=2 expandtab " Sets tab and indentation as spaces

" Basic
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
" Use `:hi Normal`, and `:hi StatusLine` for finding colours
let &t_SI = "\e[6 q" " Sets the cursor to thin bar in insert mode
let &t_EI = "\e[2 q"
set background=dark
colorscheme gruvbox8
let g:gruvbox_italics=1
syntax on
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
hi CursorLine ctermfg=none ctermbg=236
set fillchars+=vert:\█
hi VertSplit ctermfg=237
hi SignColumn ctermbg=none
" Should make tilde disappear, but doesn't
hi EndOfBuffer ctermfg=bg

" Tab
nnoremap <silent><C-w>t :tabnew<CR>

" Buffer
nnoremap <silent><Leader>r :e<CR>
nnoremap <silent><Leader>R :bufdo e!<CR><C-w>:b#<CR>:e<CR> 
" Fix so this doesn't swap back to prev buffer when there's no term.
" Use a func to do so

" Search
nnoremap <Leader>F :vimgrep 

" Highlight
nnoremap <silent><Leader>c :nohlsearch<CR>

" Terminal
nnoremap <silent><Leader>T :terminal<CR><C-w>T
nnoremap <silent><Leader>t :terminal<CR>
set termwinsize=12*0 " Smaller terminal

" ALE
let g:ale_enabled=1
let g:ale_set_balloons=1
let g:ale_completion_enabled=1
let g:airline#extensions#ale#enabled=1
let g:ale_lsp_show_message_severity='error'
let g:ale_linters = { 'javascript': ['prettier', 'eslint'] }
let g:ale_fixers = { 'javascript': ['prettier', 'eslint'] }

" FZF
nnoremap <silent><Leader>f :Ag<CR>
nnoremap <silent><Leader>o :Files<CR>
nnoremap <silent><Leader>b :Buffers<CR>
let s:ag_options = ' --skip-vcs-ignores --smart-case '
nnoremap <silent><Leader>ag :Ag <C-R><C-W><CR>

" NERDTree
let g:NERDTreeWinSize=45
let g:NERDTreeShowHidden=1
let g:NERDTreeChDirMode=3
nnoremap <silent><Leader><Tab> :NERDTreeToggle<CR> :NERDTreeRefreshRoot<CR>

" Wrap
nnoremap <silent><Leader>w :set wrap!<CR>

" Goyo
let g:goyo_width=120
let g:goyo_linenr=1
" Jankiest solution to Goyo ignoring highlight groups by resetting them each
" time this is called 
nnoremap <silent><Leader>l :Goyo<bar>hi StatusLineNC ctermfg=none<CR>:hi VertSplit ctermfg=237<CR>:hi CursorLine ctermfg=none ctermbg=236<CR>:hi SignColumn ctermbg=none<CR>

" Limelight
let g:limelight_conceal_ctermfg=8
nnoremap <silent><Leader>L :Limelight!!<CR>

" Git Fugitive
set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P

" Glow
" Using quotes around %:p because otherwise it won't open files with spaces in names
nnoremap <silent><Leader>v :silent !glow -p "%:p"<CR><C-L>
