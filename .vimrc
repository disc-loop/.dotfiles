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
Plug 'github/copilot.vim'
Plug 'CopilotC-Nvim/CopilotChat.nvim'
Plug 'nvim-lua/plenary.nvim'
" Plug 'mattn/emmet-vim'
call plug#end()

let mapleader=","

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
" nnoremap <silent> K :call ShowDocumentation()<CR>
" function! ShowDocumentation()
"   if CocAction('hasProvider', 'hover')
"     call CocActionAsync('doHover')
"   else
"     call feedkeys('K', 'in')
"   endif
" endfunction

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
nnoremap <silent><leader>gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent>K  <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent><leader>gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent><leader>gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent><leader>rn <cmd>lua vim.lsp.buf.rename()<CR>

" Copilot
let g:copilot_enabled = 0
nmap <Leader>ce :Copilot enable<CR>
nmap <Leader>cd :Copilot disable<CR>
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

lua << EOF
vim.diagnostic.config({
  virtual_text = true, -- Show inline diagnostic messages
  signs = true, -- Show signs in the gutter
  underline = true, -- Underline problematic code
  update_in_insert = false, -- Do not update diagnostics in insert mode
  float = { border = "rounded" },
})
vim.keymap.set("n", "<leader>dt",
  function()
    if vim.diagnostic.is_enabled() then
      vim.diagnostic.disable()
    else
    vim.diagnostic.enable()
    end
  end
)
vim.api.nvim_set_hl(0, "IncSearch", { bg = "#45707a", fg = "#f9f5d7" }) -- TODO: Fix this hack
vim.keymap.set("n", "K",
  function()
    vim.lsp.buf.hover({ border = "rounded" })
  end
)
require("CopilotChat").setup{ window = { layout = "horizontal", height = 0.3 } }
vim.lsp.config('ts_ls', {
  init_options = { hostInfo = 'neovim' },
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
  root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
  handlers = {
    -- handle rename request for certain code actions like extracting functions / types
    ['_typescript.rename'] = function(_, result, ctx)
      local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
      vim.lsp.util.show_document({
        uri = result.textDocument.uri,
        range = {
          start = result.position,
          ['end'] = result.position,
        },
      }, client.offset_encoding)
      vim.lsp.buf.rename()
      return vim.NIL
    end,
  },
  on_attach = function(client)
    -- ts_ls provides `source.*` code actions that apply to the whole file. These only appear in
    -- `vim.lsp.buf.code_action()` if specified in `context.only`.
    vim.api.nvim_buf_create_user_command(0, 'LspTypescriptSourceAction', function()
      local source_actions = vim.tbl_filter(function(action)
        return vim.startswith(action, 'source.')
      end, client.server_capabilities.codeActionProvider.codeActionKinds)
      vim.lsp.buf.code_action({
        context = {
          only = source_actions,
        },
      })
    end, {})
  end,
})
vim.lsp.enable('ts_ls')
vim.lsp.config('solargraph', {
  cmd = { "/Users/Tom/.rbenv/versions/3.3.8/bin/solargraph", "stdio" },
  root_markers = { "Gemfile", ".git" },
  filetypes = { "ruby" },
  settings = {
    solargraph = {
      autoformat = true,
      completion = true,
      diagnostic = true,
      folding = true,
      references = true,
      rename = true,
      symbols = true,
    },
  },
})
vim.lsp.enable('solargraph')
vim.lsp.config('gopls', {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_markers = { 'go.mod', 'go.sum' },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
})
vim.lsp.enable('gopls')
-- Use the following configuration to have your imports organized on save using the logic of goimports and your code formatted.
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({async = false})
  end
})
vim.lsp.config('jsonls', {
  cmd = { "/usr/local/Cellar/node/24.2.0/bin//vscode-json-language-server", "--stdio" }, -- TODO: Figure out why this can't be found
  filetypes = { "json", "jsonc" },
  init_options = { provideFormatter = true },
  root_markers = { ".git" },
})
vim.lsp.enable('jsonls')
vim.lsp.config['luals'] = {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      }
    }
  }
}
vim.lsp.enable('luals')
EOF
