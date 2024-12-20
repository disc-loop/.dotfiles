" FZF runtime path
set rtp+=/usr/local/opt/fzf

" ======== Plugin Installation
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'sainnhe/gruvbox-material'
Plug 'editorconfig/editorconfig-vim'
Plug 'neoclide/coc.nvim' ", {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'fatih/vim-go'
Plug 'mattn/emmet-vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'github/copilot.vim'
" Plugin 'reedes/vim-wordy' " Helps improve writing by highlighting weak prose
call plug#end()

" ======== General
filetype plugin indent on " Enables filetype detection, both for plugins and automatic indentation
set relativenumber cursorline " Sets relative line numbering and shows the line the cursor is on
set hlsearch incsearch ignorecase " Highlight pending searches and search results, ignores case and searches globally
set wrap " Wrap text in windows by default
set tabstop=2 shiftwidth=2 expandtab " Sets the amount of spaces <Tab> is worth and the number of spaces to use for (auto)indentation in insert mode
set autoindent smartindent breakindent linebreak " Enables smart auto-indentation
set backspace=indent,eol,start " Enables backspacing over auto-indenting, line breaks and the start of the line
set listchars=leadmultispace:\│\ ,trail:~,tab:\│\ , " Set symbols for hidden characters
set list " Show hidden characters
set timeoutlen=1000 ttimeoutlen=0 " Sets wait time for hotkeys and <esc>
set updatetime=750 " Sets the duration before the file is written to disk. I'm using this for faster CursorHold events
set re=0 " Use new regular expression engine so Vim doesn't lag with some filetypes, e.g. .ts
set wildignore+=*/node_modules/*,*/.git/* " Ignore these patterns when file searching
if !has('nvim')
  set mouse=a ttymouse=xterm2 " Enables mouse use
endif

" ======== Appearance
if !exists('g:syntax_on')
  syntax on
endif
if !exists('g:colours_loaded')
  colorscheme gruvbox-material
  let g:airline_theme='base16_gruvbox_dark_hard'
  let hour = strftime("%H")
  if 6 <= hour && hour < 18
    set background=light
    let g:airline_theme='base16_gruvbox_light_hard'
  endif
  let &t_EI = "\e[2 q" " Sets the cursor to thin bar in insert mode
  let &t_SI = "\e[6 q"
  set fillchars+=vert:\| " For some reason, this doesn't get coloured correctly if you use █
  " hi SignColumn ctermbg=none
  " hi CursorLine ctermfg=none ctermbg=236
  " hi StatusLineNC ctermfg=237 
  " hi VertSplit ctermfg=237
  let g:airline_powerline_fonts=1
  let g:airline#extensions#tabline#enabled=1
endif

" ======== Hotkeys
let mapleader=","
" Send things to system clipboard
nmap <Leader>y "+y
nmap <Leader>Y "+Y
vmap <Leader>y "+y
vmap <Leader>Y "+Y
" Overrides command line behaviour to allow cursor to move to beginning of line
cmap <C-a> <Home>
" Clears current highlighting 
nmap <silent><Leader>c :nohlsearch<CR>
" Opens a terminal inside Vim
if has('nvim')
  nmap <silent><Leader>t :split <bar> :terminal<CR>i
  tno <C-w> <C-\><C-n><C-w>
  " Figure out how to return to normal mode like we do in nvim
  " Runs an alias I have set for Taskell and a script to manage my Kanban files 
  nmap <silent><Leader>k :terminal kb<CR>
  " Renders the current buffer in markdown using Glow, either in a new window or in the current shell
  nmap <silent><Leader>V :terminal glow -p "%"<CR>i
  nmap <silent><Leader>v :split <bar> :terminal glow -p "%"<CR>i
endif

" Move blocks of text
nnoremap <silent><C-j> :m .+1<CR>==
nnoremap <silent><C-k> :m .-2<CR>==
inoremap <silent><C-j> <Esc>:m .+1<CR>==gi
inoremap <silent><C-k> <Esc>:m .-2<CR>==gi
vnoremap <silent><C-j> :m '>+1<CR>gv=gv
vnoremap <silent><C-k> :m '<-2<CR>gv=gv

" Commentary
if has('nvim')
  map <C-_> :Commentary<CR>
else
  map <C-/> :Commentary<CR>
endif

" FZF
nmap <silent><Leader>f :Ag<CR>
nmap <silent><Leader>o :Files<CR>
nmap <silent><Leader>b :Buffers<CR>
nmap <silent><Leader>ag :Ag <C-R><C-W><CR>
" Use tab to select items in the window. This will open them in a buffer and also in the quickfix window
" WIP: Search hidden files with smart casing
" FZF Ag doesn't support options, so I will need to overwrite the function.
" let s:ag_options = ' --smart-case --hidden'

" Ranger
let g:ranger_map_keys = 0
map <leader><Tab> :Ranger<CR>

" NERDTree
" let g:NERDTreeWinSize=45
" let g:NERDTreeShowHidden=1
" let g:NERDTreeChDirMode=3
" let NERDTreeIgnore=['\.*\.sw.$', '\~$']
" nmap <silent><Leader><Tab> :NERDTreeToggle<CR> :NERDTreeRefreshRoot<CR>

" vim-go
" Use CoC gd instead
let g:go_def_mapping_enabled = 0
" CoC has the same mapping for reading docs so disabling
let g:go_doc_keywordprg_enabled = 0

" CoC Sample Config
" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
" set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

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
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

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

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>4  <Plug>(coc-format-selected)
nmap <leader>4  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
" nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>" 
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')
" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
" TOM: This stopped working for some reason
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>d  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Emmet
" TODO: Find a better key as this breaks scrolling
" let g:user_emmet_leader_key='<C-e>'

" Copilot
let g:copilot_enabled = 0
imap <silent><script><expr> <C-c> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

" Annotations / commenting
highlight link MyComment Todo
match MyComment /\<TOM\>\ze:/
" Remember to find and clear the commentary at the end:
" :vim /TOM:/ /**
" Might need to check that it's not multiline comments before cfdo delete
nmap <silent><Leader>n oTOM: <Esc>:Commentary<CR>A
nmap <silent><Leader>N OTOM: <Esc>:Commentary<CR>A
