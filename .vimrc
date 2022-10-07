" FZF runtime path
set rtp+=/usr/local/opt/fzf

" ======== Plugin Installation
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/goyo.vim'
Plug 'powerline/powerline-fonts'
Plug 'vim-airline/vim-airline'
Plug 'lifepillar/vim-gruvbox8'
Plug 'preservim/nerdtree'
Plug 'editorconfig/editorconfig-vim'
Plug 'dense-analysis/ale'
Plug 'fatih/vim-go'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'

call plug#end()

" ======== General
set number relativenumber cursorline " Sets relative line numbering and shows the line the cursor is on
set hlsearch incsearch ignorecase wrapscan " Highlight pending searches and search results, ignores case and searches globally
set nowrap " Do not wrap text in windows by default
set tabstop=2 shiftwidth=2 expandtab " Sets the amount of spaces <Tab> is worth and the number of spaces to use for (auto)indentation in insert mode
set autoindent smartindent " Enables smart auto-indentation
filetype plugin indent on " Enables filetype detection, both for plugins and automatic indentation
set backspace=indent,eol,start " Enables backspacing over auto-indenting, line breaks and the start of the line
set splitbelow splitright " New splits are initialised from the bottom right
set listchars=eol:¬,tab:>>,trail:~,space:_ " Set symbols for hidden characters
set termwinsize=18*0 " Sets the 'terminal' window size
set mouse=a ttymouse=xterm2 " Enables mouse use
set timeoutlen=1000 ttimeoutlen=0 " Sets wait time for hotkeys and <esc>
set updatetime=750 " Sets the duration before the file is written to disk. I'm using this for faster CursorHold events
set re=0 " Use new regular expression engine so Vim doesn't lag with some filetypes, e.g. .ts
set wildignore+=node_modules/**,.git/** " Ignore these patterns when file searching 

" ======== Appearance
syntax on
colorscheme gruvbox8
let g:gruvbox_italics=1
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let &t_EI = "\e[2 q" " Sets the cursor to thin bar in insert mode
let &t_SI = "\e[6 q" " 
" This function exists as a workaround due to Goyo not resetting the appearance settings properly after exit
fun SetAppearance()
  set background=dark
  set fillchars+=vert:\█ " Makes the vertical bar on the left thicc
  " Tip: Use `:hi Normal`, and `:hi StatusLine` for finding the colours of highlight groups
  " This changes the colour of the intersecting square between NERDTree and the statusline
  hi StatusLineNC ctermfg=237 
  hi VertSplit ctermfg=237
  " WIP: Should make the tilde at the eol disappear, but doesn't
  " hi EndOfBuffer ctermfg=bg 
  hi CursorLine ctermfg=none ctermbg=236
  hi SignColumn ctermbg=none
endfun
call SetAppearance()

" ======== Hotkeys
let mapleader=","
" Overrides command line behaviour to allow cursor to move to beginning of line
cmap <C-a> <Home>
" Quickfix navigation
nmap <silent><C-q> :copen<CR>
nmap <silent><C-n> :cn<CR>
nmap <silent><C-p> :cp<CR>
" Searches for the word under the cursor in the directory of your choosing
nmap <Leader>F :vimgrep /<C-r><C-w>/ ./*
" Clears current highlighting 
nmap <silent><Leader>c :nohlsearch<CR>
" Opens a terminal inside Vim either in the current tab or in a new one
nmap <silent><Leader>t :terminal<CR>
nmap <silent><Leader>T :terminal<CR><C-w>T
" Runs an alias I have set for Taskell and a script to manage my Kanban files 
nmap <silent><Leader>k :terminal ++shell ++close kb<CR>
" Renders the current buffer in markdown using Glow, either in a new window or in the current shell
nmap <silent><Leader>v :terminal ++shell ++close glow -p "%:p"<CR>
nmap <silent><Leader>V :silent !glow -p "%:p"<CR><C-L>
" Runs an alias that renders pages from Learn X in Y Minutes in markdown in a new window
nmap <Leader>l :terminal ++shell ++close learn 

" ALE
let g:ale_linters = {
  \ 'go': ['gopls', 'golangcli-lint'],
  \ 'scala': ['metals'],
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
nmap <silent><Leader>gd :ALEGoToDefinition<CR>
nmap <silent><Leader>d :ALEDetail<CR>
nmap <silent><Leader>an :ALENext<CR>
nmap <silent><Leader>ab :ALEPrevious<CR>
nmap <silent><Leader>af :ALEFindReferences<CR>

" FZF
nmap <silent><Leader>f :Ag<CR>
nmap <silent><Leader>o :Files<CR>
nmap <silent><Leader>b :Buffers<CR>
nmap <silent><Leader>ag :Ag <C-R><C-W><CR>
" WIP: Search hidden files with smart casing
" FZF Ag doesn't support options, so I will need to overwrite the function.
" let s:ag_options = ' --smart-case --hidden'

" NERDTree
let g:NERDTreeWinSize=45
let g:NERDTreeShowHidden=1
let g:NERDTreeChDirMode=3
let NERDTreeIgnore=['\.*\.sw.$', '\~$']
nmap <silent><Leader><Tab> :NERDTreeToggle<CR> :NERDTreeRefreshRoot<CR>

" Goyo
let g:goyo_width=120
let g:goyo_linenr=1
nmap <silent><Leader>m :Goyo<bar>call SetAppearance()<CR>
