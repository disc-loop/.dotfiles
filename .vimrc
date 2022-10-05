" FZF runtime path
set rtp+=/usr/local/opt/fzf

" ======== Plugins
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/goyo.vim'
Plug 'powerline/powerline-fonts'
Plug 'vim-airline/vim-airline'
Plug 'lifepillar/vim-gruvbox8'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'preservim/nerdtree'
Plug 'fatih/vim-go'
Plug 'editorconfig/editorconfig-vim'
Plug 'dense-analysis/ale'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'

call plug#end()

" ======== Basic
filetype plugin indent on " Indentation
set ts=2 sw=2 expandtab " Sets tab and indentation as spaces
set backspace=indent,eol,start
set cursorline ruler
set number relativenumber
set hlsearch incsearch
set ignorecase
set wrapscan
set autoindent smartindent
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
set wildignore+=node_modules/**,.git/** " These get ignored in file searching
set re=0 " Use new regular expression engine so vim doesn't lag with typescript files 
set listchars=eol:¬,tab:>>,trail:~,space:_ " Show hidden characters

" ======== Hotkeys
let mapleader=","

" Overrides command line behaviour to allow cursor to move to beginning of line
cnoremap <C-a> <Home>

" Wrap
nnoremap <silent><Leader>w :set wrap!<CR>

" Quickfix
nnoremap <silent><C-q> :copen<CR>
nnoremap <silent><C-n> :cn<CR>
nnoremap <silent><C-p> :cp<CR>

" Search cursor word
" The trailing whitespace is necessary.
" This can be improved with a custom command that performs 'copen'
" at the end.
nnoremap <Leader>F :vimgrep /<C-r><C-w>/ ./*

" Clear current highlight
nnoremap <silent><Leader>c :nohlsearch<CR>

" Open terminal
nnoremap <silent><Leader>T :terminal<CR><C-w>T
nnoremap <silent><Leader>t :terminal<CR>
set termwinsize=17*0

" Refresh buffers (WIP)
" Fix so this doesn't swap back to prev buffer when there's no term.
" Use a func to do so
nnoremap <silent><Leader>R :bufdo e!<CR><C-w>:b#<CR>:e<CR> 

" ALE
" Remember to properly install the linters / fixers first
" e.g. I needed to do `npm init @eslint/config` before it worked
let g:ale_linters = {
  \ 'scala': ['metals'],
  \ 'go': ['gopls', 'golangcli-lint'],
  \} 
let g:ale_fixers = { 
  \ 'javascript': ['eslint', 'prettier'],
  \ 'typescript': ['eslint', 'prettier'],
  \ 'scala': ['scalafmt'],
  \}
let g:ale_fix_on_save=1
let g:ale_set_balloons=1
let g:ale_completion_enabled=1
let g:airline#extensions#ale#enabled=1
nnoremap <silent><Leader>gd :ALEGoToDefinition<CR>
nnoremap <silent><Leader>d :ALEDetail<CR>
nnoremap <silent><Leader>an :ALENext<CR>
nnoremap <silent><Leader>ab :ALEPrevious<CR>
nnoremap <silent><Leader>af :ALEFindReferences<CR>

" FZF
nnoremap <silent><Leader>f :Ag<CR>
nnoremap <silent><Leader>o :Files<CR>
nnoremap <silent><Leader>b :Buffers<CR>
nnoremap <silent><Leader>ag :Ag <C-R><C-W><CR>
" Don't think this does anything. FZF Ag doesn't support options, 
" so you will need to overwrite the function.
" let s:ag_options = ' --smart-case --hidden'

" NERDTree
let g:NERDTreeWinSize=45
let g:NERDTreeShowHidden=1
let g:NERDTreeChDirMode=3
" Not sure why the first pattern works. Come back to understand this.
let NERDTreeIgnore=['\.*\.sw.$', '\~$']
nnoremap <silent><Leader><Tab> :NERDTreeToggle<CR> :NERDTreeRefreshRoot<CR>

" Goyo
let g:goyo_width=120
let g:goyo_linenr=1
nnoremap <silent><Leader>m :Goyo <bar>call SetAppearance()<CR>

" Glow
" Using quotes around %:p because otherwise it won't open files with spaces in names
nnoremap <silent><Leader>V :silent !glow -p "%:p"<CR><C-L>
nnoremap <silent><Leader>v :terminal ++shell ++close glow -p "%:p"<CR>

" Learn X in Y
nnoremap <Leader>l :terminal ++shell ++close learn 

" ======== Appearance
syntax on
" Use `:hi Normal`, and `:hi StatusLine` for finding colours
fun SetAppearance()
  set background=dark
  set fillchars+=vert:\█
  " This changes the stupid little intersection square 
  hi StatusLineNC ctermfg=237 
  hi VertSplit ctermfg=237
  " hi EndOfBuffer ctermfg=bg " Should make tilde disappear, but doesn't
  hi CursorLine ctermfg=none ctermbg=236
  hi SignColumn ctermbg=none
endfun

colorscheme gruvbox8
let g:gruvbox_italics=1
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let &t_SI = "\e[6 q" " Sets the cursor to thin bar in insert mode
let &t_EI = "\e[2 q"
call SetAppearance()
