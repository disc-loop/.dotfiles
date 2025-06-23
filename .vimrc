" [ Plugins ]
call plug#begin('~/.vim/plugged')
Plug 'sainnhe/gruvbox-material'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug '/usr/local/opt/fzf'
Plug 'tpope/vim-commentary'
Plug 'francoiscabrol/ranger.vim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'petertriho/cmp-git'
Plug 'nvim-lua/plenary.nvim'
Plug 'CopilotC-Nvim/CopilotChat.nvim'
Plug 'github/copilot.vim'
call plug#end()

" [ Commands ]
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

" [ Appearance ]
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_better_performance = 1
" Sync appearance with system
function! SyncAppearance()
  " TODO: Handle Linux
  if has("macunix")
    let l:appearance = system('defaults read -g AppleInterfaceStyle 2>/dev/null')
    if l:appearance =~ "Dark"
      set background=dark
      let g:airline_theme='base16_gruvbox_dark_hard'
    else
      set background=light
      let g:airline_theme='base16_gruvbox_light_hard'
    endif
  endif
endfunction
call SyncAppearance()
colorscheme gruvbox-material

" Set cursor to a thin bar in insert mode
let &t_EI = "\e[2 q"
let &t_SI = "\e[6 q"

" [ Keymaps & Plugin Config ]
let mapleader=","

" Source config changes
map <Leader>so :source ~/.vimrc<CR>

" Sync appearance changes with system
map <Leader>sa :call SyncAppearance()<CR>

" Personal notes that look like this: TOM:
highlight link PersonalNote Todo
match PersonalNote /\<TOM\>\ze:/
nmap <silent><Leader>n oTOM: <Esc>:Commentary<CR>A
nmap <silent><Leader>N OTOM: <Esc>:Commentary<CR>A

" Make search item under cursor match Todo colours (must be cleared before overriding)
highlight clear IncSearch
highlight link IncSearch Todo

" More traditional cursor navigation in command mode
cmap <C-a> <Home>

" Copy to and paste from system clipboard
nmap <Leader>y "+y
nmap <Leader>Y "+Y
vmap <Leader>y "+y
vmap <Leader>Y "+Y
nmap <Leader>p "+p
nmap <Leader>P "+P

" Terminal
nmap <silent><Leader>t :split <bar> :terminal<CR>i
tno <C-w> <C-\><C-n><C-w>

" Toggle comments
nmap <C-_> :Commentary<CR>
vmap <C-_> :Commentary<CR>

" FZF
" Hint: Use tab to select items
nmap <silent><Leader>f :Ag<CR>
nmap <silent><Leader>o :Files<CR>
nmap <silent><Leader>b :Buffers<CR>
nmap <silent><Leader>ag :Ag <C-R><C-W><CR>
" Overrides Ag command so that specific directories are ignored
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--ignore node_modules --hidden', fzf#vim#with_preview(), <bang>0)

" Ranger
let g:ranger_map_keys = 0
map <leader><Tab> :Ranger<CR>

" [ LSP, Completion, and AI ]
lua << EOF

-- Golang
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
-- Import modules and format code on save (from the LSP docs)
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
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
vim.lsp.enable('gopls')

-- Typescript and Javascript
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

-- JSON
vim.lsp.config('jsonls', {
  cmd = { "/usr/local/Cellar/node/24.2.0/bin//vscode-json-language-server", "--stdio" }, -- TODO: Figure out why this can't be found
  filetypes = { "json", "jsonc" },
  init_options = { provideFormatter = true },
  root_markers = { ".git" },
})
vim.lsp.enable('jsonls')

-- Ruby
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

-- Lua
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

-- Diagnostics
vim.diagnostic.config({
  virtual_text = true, -- Show inline diagnostic messages
  signs = true, -- Show signs in the gutter
  underline = true, -- Underline problematic code
  update_in_insert = false, -- Do not update diagnostics in insert mode
  float = { border = "rounded" },
})

-- Shows diagnostics in floating window while hovering on line
vim.api.nvim_create_autocmd("CursorHold", {
  pattern = "*",
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false })
  end
})

-- Toggles diagnostics
vim.keymap.set("n", "<leader>dt",
  function()
    n = vim.api.nvim_get_current_buff()
    if vim.diagnostic.is_enabled({ bufnr = n }) then
      vim.diagnostic.disable(n)
    else
    vim.diagnostic.enable(n)
    end
  end
)

-- Show information for symbol
vim.keymap.set("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end, { silent = true })

-- Go to definition, go to implementation, find references, and symbol rename
vim.keymap.set("n", "<leader>gd", function() vim.lsp.buf.definition() end, { silent = true })
vim.keymap.set("n", "<leader>gi", function() vim.lsp.buf.implementation() end, { silent = true })
vim.keymap.set("n", "<leader>gr", function() vim.lsp.buf.references() end, { silent = true })
vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, { silent = true })

-- Completion
local cmp = require('cmp')
cmp.setup({
  sources = {
    { name = 'nvim_lsp' }
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  })
})

-- Git completions
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' },
  }, {
    { name = 'buffer' },
  })
})
require("cmp_git").setup()

-- Command completions
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

-- Copilot
require("CopilotChat").setup{ window = { layout = "horizontal", height = 0.3 } }
vim.g.copilot_enabled = false
vim.g.copilot_no_tab_map = true
vim.keymap.set("n", "<leader>ce", ":Copilot enable<CR>")
vim.keymap.set("n", "<leader>cd", ":Copilot disable<CR>")
vim.keymap.set("i", "<C-c>", "copilot#Accept('<CR>')", { expr = true, silent = true, script = true })
vim.keymap.set("n", "<leader>cc", ":CopilotChat<CR>")
vim.keymap.set("v", "<leader>cc", ":CopilotChat<CR>")

EOF
