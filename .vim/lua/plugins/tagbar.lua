local g = vim.g
local map = require('util').map

g.target_left = 0
g.tagbar_autofocus = 1
map('', '<leader>t', ':Tagbar<CR>')
