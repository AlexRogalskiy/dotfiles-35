local g = vim.g
local api = vim.api
local cmd = vim.cmd
local ncmd = vim.api.nvim_command
local o, wo, bo = vim.o, vim.wo, vim.bo

local function set(opt, v, scopes)
    scopes = scopes or {o}
    for _, s in ipairs(scopes) do s[opt] = v end
end

local function map(modes, lhs, rhs, opts)
    -- noremap = true, slient = true, expr = false
    opts = opts or {}
    opts.noremap = opts.noremap == nil and true or opts.noremap
    if type(modes) == 'string' then modes = {modes} end
    for _, mode in ipairs(modes) do api.nvim_set_keymap(mode, lhs, rhs, opts) end
end

-- Leader key
g.mapleader = [[ ]]

ncmd('filetype plugin indent on')

-- Color scheme
set('background', 'dark')
set('termguicolors', true)
cmd[[colorscheme tokyonight]]

-- Settings
local buffer = {o, bo}
local window = {o, wo}
set('langmenu', 'zh_CN.UTF-8')
set('helplang', 'cn')
set('encoding', 'utf-8')
set('fencs', 'utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936')
set('hidden', true)
set('wildmenu', true)
set('hlsearch', true)
set('incsearch', true)
set('matchtime', 1)
set('showmatch', true)
set('updatetime', 100)
set('ignorecase', true)
set('smarttab', true)
set('expandtab', true)
set('laststatus', 2)
set('showcmd', true)
set('ruler', true)
set('history', 300)
set('backup', false)
set('swapfile', false)
set('foldenable', false)
set('autoread', true)
set('autowrite', true)
set('mouse', 'a')

set('number', true, window)
set('cursorline', true, window)
set('cursorcolumn', true, window)

set('textwidth', 120, buffer)
set('smartindent', true, buffer)
set('autoindent', true, buffer)
set('cindent', true, buffer)
set('shiftwidth', 4, buffer)
set('softtabstop', 4, buffer)
set('tabstop', 4, buffer)

-- Auto commands
-- autocmd('', [[InsertLeave * se nocul]], true)
-- autocmd('', [[InsertEnter * se cul]], true)

cmd [[ autocmd FileType json,markdown let g:indentLine_conceallevel=0 ]]
cmd [[ autocmd FileType php setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120 ]]
cmd [[ autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120 ]]
cmd [[ autocmd FileType json setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab ]]
cmd [[ autocmd FileType go setlocal tabstop=8 shiftwidth=8 softtabstop=8 textwidth=120 noexpandtab ]]
cmd [[ autocmd FileType html,htmldjango,xhtml,haml setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=0 ]]
cmd [[ autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=0 expandtab ]]
cmd [[ autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120 ]]
cmd [[ autocmd FileType less,sass,scss,css setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120 ]]
cmd [[ autocmd FileType javascript,javascript.jsx,javascriptreact,typescript,typescriptreact setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab ]]

-- Key bindings
map('', '<c-a>', 'ggVG$"+y')
map('v', '<c-c>', '"+y')
map('n', '<tab>', 'V')
map('n', '<s-tab>', 'V<')
map('v', '<tab>', '>gv')
map('v', '<s-tab>', '<gv')
map('i', '<c-b>', '<c-o>b')
map('i', '<c-f>', '<c-o>l')
map('i', '<c-j>', '<c-o>j')
map('i', '<c-k>', '<c-o>k')
map('c', '<c-b>', '<Left>')
map('c', '<c-f>', '<Right>')

-- NVIM Treesitter
require'nvim-treesitter.configs'.setup{
    ensure_installed = "maintained",
    highlight = {
        enable = true,
    },
}
ncmd('set foldmethod=expr')
ncmd('set foldexpr=nvim_treesitter#foldexpr()')

-- NVIM Web Devicons
require'nvim-web-devicons'.setup {
    override = {
        zsh = {
            icon = "",
            color = "#428850",
            name = "Zsh"
        }
    };
    default = true;
}

-- NVIM Bufferline
require'bufferline'.setup{
    options = {
        show_buffer_icons = true,
        indicator_icon = '▎',
        show_close_icon = false,
        modified_icon = '✥',
    }
}

-- TAGBAR
g.target_left = 0
g.tagbar_autofocus = 1
map('', '<leader>t', ':Tagbar<CR>')

-- FLOATERM
g.floaterm_autoclose = 2
g.floaterm_autohide = 'v:false'
g.floaterm_height = 0.4
g.floaterm_position = 'bottomright'
g.floaterm_keymap_toggle = '<c-t>'

map('n', '<leader>r', 'V:FloatermSend<CR>:FloatermToggle<CR>')
map('v', '<leader>r', ':FloatermSend<CR>:FloatermToggle<CR>')

-- INDENTLINE
g.indentLine_conceallevel = 1
g.indentLine_color_term = 239
g.indentLine_char = '¦'

-- NERDCOMMENTER
g.NERDSpaceDelims = 1
g.NERDDefaultAlign = 'left'

-- EASYMOTION
g.EasyMotion_smartcase = 1
map('', '<leader>l', '<Plug>(easymotion-lineforward)', {noremap = false})
map('', '<leader>j', '<Plug>(easymotion-j)', {noremap = false})
map('', '<leader>k', '<Plug>(easymotion-k)', {noremap = false})
map('', '<leader>h', '<Plug>(easymotion-linebackward)', {noremap = false})
map('', '<leader>w', '<Plug>(easymotion-w)', {noremap = false})
map('', '<leader>s', '<Plug>(easymotion-overwin-f)', {noremap = false})
cmd [[ autocmd User EasyMotionPromptBegin LspStop ]]
cmd [[ autocmd User EasyMotionPromptEnd LspStart ]]

-- CHOOSEWIN
map('n', '-', '<Plug>(choosewin)', {noremap = false})

-- LSP
local nvim_lsp = require'lspconfig'
cmd [[autocmd ColorScheme * highlight NormalFloat guibg=#1f2335]]
cmd [[autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

local on_attach = function(_, bufnr)
    local function buf_set_keymap(...) api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    -- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    -- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    -- buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    -- vim.lsp.handlers["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border})
    -- vim.lsp.handlers["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border})
    -- vim.lsp.handlers["textDocument/definition"] = goto_definition('vsplit')
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'tsserver', 'gopls', 'vimls' }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        flags = {
          debounce_text_changes = 150,
        }
    }
end
-- vim.cmd [[ autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false}) ]]

-- COC
g.coc_global_extensions = {
    "coc-yank", "coc-explorer", "coc-git", "coc-pairs",
    "coc-yaml", "coc-highlight", "coc-tabnine", "coc-clangd"
}

map('', '<leader>e', ':CocCommand explorer --no-focus --width=30<CR>', {silent=false})

cmd [[ autocmd VimEnter * CocCommand explorer --no-focus --width=30 ]]
cmd [[ autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif ]]

-- AIRLINE
g.airline_left_alt_sep = '❯'
g.airline_right_alt_sep = '❮'
g.airline_symbols = {
    ['branch'] = '⎇'
}

-- FZF
-- map('n', '<C-p>', ':Files<CR>')
-- map('n', '<leader>b', ':Buffers<CR>')
-- map('n', '<leader>f', ':Ag<CR>')
-- ncmd('set rtp+=/usr/local/opt/fzf')
-- g.fzf_action = {
--   ['ctrl-s'] = 'split',
--   ['ctrl-v'] = 'vsplit'
-- }
-- g.fzf_layout = {
--   ['window'] = {
--     ['height'] = 0.4,
--     ['width'] = 0.6
--   }
-- }

-- TELESCOPE
local actions = require('telescope.actions')
require'telescope'.setup{
    defaults = {
        layout_config = {
            horizontal = {
                width = 0.6,
                height = 0.4
            }
        },
        mappings = {
            i = {
                ["<esc>"] = actions.close,
            },
        }
    }
}
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
