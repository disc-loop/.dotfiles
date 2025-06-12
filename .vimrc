" ======== Plugin Installation
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-commentary'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug '/usr/local/opt/fzf'
Plug 'sainnhe/gruvbox-material'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'francoiscabrol/ranger.vim'
Plug 'fatih/vim-go'
Plug 'github/copilot.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'CopilotC-Nvim/CopilotChat.nvim'
Plug 'neovim/nvim-lspconfig'
" Plug 'mattn/emmet-vim'
call plug#end()

lua << EOF
require("CopilotChat").setup {
  window = {
    layout = "horizontal",
    height = 0.3,
  }
}
require('lspconfig').ruby_lsp.setup({
  cmd = { "/Users/Tom/.rbenv/versions/3.2.2/bin/solargraph", "stdio" },
  root_dir = require("lspconfig.util").root_pattern("Gemfile", ".git", "."),
  settings = {
    solargraph = {
      diagnostics = true,
      formatting = true,
    },
  },
})
EOF

" ======== General
filetype plugin indent on " Enables filetype detection, both for plugins and automatic indentation
set number relativenumber cursorline " Sets relative line numbering and shows the line the cursor is on
set hlsearch incsearch ignorecase " Highlight pending searches and search results, ignores case and searches globally
set wrap " Wrap text in windows by default
set tabstop=2 shiftwidth=2 expandtab " Sets the amount of spaces <Tab> is worth and the number of spaces to use for (auto)indentation in insert mode
set splitright splitbelow
set autoindent smartindent breakindent linebreak " Enables smart auto-indentation
set backspace=indent,eol,start " Enables backspacing over auto-indenting, line breaks and the start of the line
set list " Show hidden characters
set listchars=leadmultispace:\│\ ,trail:~,tab:\│\ , " Set symbols for hidden characters
set timeoutlen=1000 ttimeoutlen=0 " Sets wait time for hotkeys and <esc>
set updatetime=750 " Sets the duration before the file is written to disk. I'm using this for faster CursorHold events
set re=0 " Use new regular expression engine so Vim doesn't lag with some filetypes, e.g. .ts
set wildignore+=*/node_modules/*,*/.git/* " Ignore these patterns when file searching
set encoding=utf-8
set nobackup
set nowritebackup
set signcolumn=yes
if !has('nvim')
  set mouse=a ttymouse=xterm2 " Enables mouse use
endif

" ======== Appearance
" if !exists('g:syntax_on')
"   syntax on
" endif
colorscheme gruvbox-material
let g:gruvbox_material_background = 'hard' " soft, medium, hard

" Match system appearance
if has("macunix")
  if system('defaults read -g AppleInterfaceStyle 2>/dev/null') =~ "Dark"
    let g:airline_theme='gruvbox'
    set background=dark
  else
    set background=light
  endif
endif

" Set cursor to a thin bar in insert mode
let &t_EI = "\e[2 q"
let &t_SI = "\e[6 q"
set fillchars+=vert:\| " For some reason, this doesn't get coloured correctly if you use █

" ======== Hotkeys
let mapleader=","

" Copy to and paste from system clipboard
nmap <Leader>y "+y
nmap <Leader>Y "+Y
vmap <Leader>y "+y
vmap <Leader>Y "+Y
nmap <Leader>p "+p
nmap <Leader>P "+P

" More traditional cursor navigation in command mode
cmap <C-a> <Home>

" Terminal
if has('nvim')
  nmap <silent><Leader>t :split <bar> :terminal<CR>i
  tno <C-w> <C-\><C-n><C-w>
endif

" Move blocks
nnoremap <silent><C-j> :m .+1<CR>==
nnoremap <silent><C-k> :m .-2<CR>==
inoremap <silent><C-j> <Esc>:m .+1<CR>==gi
inoremap <silent><C-k> <Esc>:m .-2<CR>==gi
vnoremap <silent><C-j> :m '>+1<CR>gv=gv
vnoremap <silent><C-k> :m '<-2<CR>gv=gv

" Toggle comments
map <C-_> :Commentary<CR>

" FZF
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--ignore node_modules --hidden', fzf#vim#with_preview(), <bang>0)
" Hint: Use tab to select items in the window.
" This will open them in a buffer and also in the quickfix window.
nmap <silent><Leader>f :Ag<CR>
nmap <silent><Leader>o :Files<CR>
nmap <silent><Leader>b :Buffers<CR>
nmap <silent><Leader>ag :Ag <C-R><C-W><CR>

" Ranger
let g:ranger_map_keys = 0
map <leader><Tab> :Ranger<CR>

" Vim-go
" Disable jumping to definition and symbol info as CoC will handle this
let g:go_def_mapping_enabled = 0
let g:go_doc_keywordprg_enabled = 0

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" GoTo code navigation
nmap <silent><Leader>gd <Plug>(coc-definition)
nmap <silent><Leader>gy <Plug>(coc-type-definition)
nmap <silent><Leader>gi <Plug>(coc-implementation)
nmap <silent><Leader>gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Rename symbol
nmap <leader>rn <Plug>(coc-rename)

" Quickfix
nmap <leader>qf  <Plug>(coc-fix-current)

" Refactor
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Scroll pop-up windows
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Diagnostics
nnoremap <silent><nowait> <space>d  :<C-u>CocList diagnostics<cr>

" Emmet
let g:user_emmet_leader_key='<C-e>'

" Ruby
" Show function signatures and info
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })

" Use LSP for goto-definition and references
" nnoremap <silent><leader>gd <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent>K  <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent><leader>gr <cmd>lua vim.lsp.buf.references()<CR>
" nnoremap <silent><leader>gi <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent><leader>rn <cmd>lua vim.lsp.buf.rename()<CR>

" Copilot
let g:copilot_enabled = 0
nmap <silent><Leader>ce :Copilot enable
nmap <silent><Leader>cd :Copilot disable
imap <silent><script><expr> <C-c> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true
nmap <silent><Leader>cc :CopilotChat<CR>
vmap <silent><Leader>cc :CopilotChat<CR>

" Personal notes
" Hint: Find and clear the notes prior to committing code:
" `:vim /TOM:/ /**`
highlight link MyComment Todo
match MyComment /\<TOM\>\ze:/
" Might need to check that it's not multiline comments before cfdo delete
nmap <silent><Leader>n oTOM: <Esc>:Commentary<CR>A
nmap <silent><Leader>N OTOM: <Esc>:Commentary<CR>A
