vim.g.maplocalleader = " "

local map = vim.api.nvim_set_keymap
local opt = {noremap = true, silent = true }

map("n", "<C-u>", "9k", opt)
map("n", "<C-d>", "9j", opt)
map("n", "H", "5h", opt)
map("n", "J", "5j", opt)
map("n", "K", "5k", opt)
map("n", "L", "5l", opt)

map('v', '<', '<gv', opt)
map('v', '>', '>gv', opt)

map('n', '=', 'nzz', opt)
map('n', '-', 'Nzz', opt)
map('n', 'Q', ':q<CR>', opt)
map('n', 'S', ':w<CR>', opt)

map('n', '<LEADER>h', '9j', opt)
map('n', '<leader>j', '<C-w>j', opt)
map('n', '<leader>k', '<C-w>k', opt)
map('n', '<leader>l', '<C-w>l', opt)

map('n', 'sl', ':set splitright<CR>:vsplit<CR>', opt)
map('n', 'sh', ':set nosplitright<CR>:vsplit<CR>', opt)
map('n', 'sj', ':set splitbelow<CR>:split<CR>', opt)
map('n', 'sk', ':set nosplitbelow<CR>:split<CR>', opt)

map('n', 'tt', ':tabe<CR>', opt)

