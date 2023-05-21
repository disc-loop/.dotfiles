" FZF runtime path
set rtp+=/usr/local/opt/fzf

" ======== Plugin Installation
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'powerline/powerline-fonts'
Plug 'vim-airline/vim-airline'
Plug 'lifepillar/vim-gruvbox8'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'preservim/nerdtree'
Plug 'editorconfig/editorconfig-vim'
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'fatih/vim-go'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-commentary'
Plug 'mattn/emmet-vim'
" Plug 'github/copilot.vim'
" Plugin 'reedes/vim-wordy' " Helps improve writing by highlighting weak prose
Plug 'ngmy/vim-rubocop'

call plug#end()

" ======== General
set showcmd " Shows the commands being used in the command line
set number relativenumber cursorline " Sets relative line numbering and shows the line the cursor is on
set hlsearch incsearch ignorecase wrapscan " Highlight pending searches and search results, ignores case and searches globally
set hidden " Allows you to swap to different buffers without writing to files
set nowrap " Do not wrap text in windows by default
set tabstop=2 shiftwidth=2 expandtab " Sets the amount of spaces <Tab> is worth and the number of spaces to use for (auto)indentation in insert mode
set autoindent smartindent " Enables smart auto-indentation
filetype plugin indent on " Enables filetype detection, both for plugins and automatic indentation
set backspace=indent,eol,start " Enables backspacing over auto-indenting, line breaks and the start of the line
set whichwrap=h,l,b,s,<,> " Specifies particular keys that let the cursor move to the next/prev line at the first/last char
set splitbelow splitright " New splits are initialised from the bottom right
set listchars=trail:~,tab:\|\ , " Set symbols for hidden characters
if !has('nvim')
  set mouse=a ttymouse=xterm2 " Enables mouse use
endif
set timeoutlen=1000 ttimeoutlen=0 " Sets wait time for hotkeys and <esc>
set updatetime=750 " Sets the duration before the file is written to disk. I'm using this for faster CursorHold events
set re=0 " Use new regular expression engine so Vim doesn't lag with some filetypes, e.g. .ts
set wildignore+=*/node_modules/*,*/.git/* " Ignore these patterns when file searching

" ======== Appearance
syntax enable
if has('nvim')
  colorscheme gruvbox
else
  colorscheme gruvbox8
endif
let &t_EI = "\e[2 q" " Sets the cursor to thin bar in insert mode
let &t_SI = "\e[6 q"
set fillchars+=vert:\█ " Makes the vertical bar on the left thicc
hi SignColumn ctermbg=none
hi CursorLine ctermfg=none ctermbg=236
hi StatusLineNC ctermfg=237 
hi VertSplit ctermfg=237
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1

" ======== Hotkeys
let mapleader=","
" Overrides command line behaviour to allow cursor to move to beginning of line
cmap <C-a> <Home>
" Clears current highlighting 
nmap <silent><Leader>c :nohlsearch<CR>
" Opens a terminal inside Vim
if has('nvim')
  nmap <silent><Leader>t :split <bar> :terminal<CR>
  tno <C-w> <C-\><C-n><C-w>
  " Add other keybinds for nvim
else 
  nmap <silent><Leader>t :terminal<CR>
  " Figure out how to return to normal mode like we do in nvim
  " Runs an alias I have set for Taskell and a script to manage my Kanban files 
  nmap <silent><Leader>k :terminal ++shell ++close kb<CR>
  " Renders the current buffer in markdown using Glow, either in a new window or in the current shell
  nmap <silent><Leader>v :terminal ++shell ++close glow -p "%:p"<CR>
  nmap <silent><Leader>V :silent !glow -p "%:p"<CR><C-L>
  " Runs an alias that renders pages from Learn X in Y Minutes in markdown in a new window
  nmap <Leader>l :terminal ++shell ++close learn 
endif
" Commentary
if has('nvim')
  map <C-/> :Commentary<CR>
else
  map <C-_> :Commentary<CR>
endif

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
" <C-g>u breaks current undo, please make your own choice
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
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

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
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

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

" Scrolling
" FIXME: Not working as intended: keybinds don't seem to work
" Try this thread: https://github.com/neoclide/coc.nvim/issues/609
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" Emmet
let g:user_emmet_leader_key='<C-e>'
