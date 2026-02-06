local utils = require('utils')

-- navigation
utils.map('n', '<C-J>', '<C-W><C-J>')
utils.map('n', '<C-K>', '<C-W><C-K>')
utils.map('n', '<C-H>', '<C-W><C-H>')

utils.map('n', '<C-L>', '<C-W><C-L>')
-- rely on copilot for this one in insert mode
vim.keymap.set('i', '<C-l>', function() end)

utils.map('n', '<Leader>h', ':topleft vnew<CR>', { noremap = false })
utils.map('n', '<Leader>l', ':botright vnew<CR>', { noremap = false })
utils.map('n', '<Leader>k', ':topleft new<CR>', { noremap = false })
utils.map('n', '<Leader>j', ':botright new<CR>', { noremap = false })
utils.map('n', '<Leader><Leader>', ':e#<CR>')

-- tabs
utils.map('n', '<Tab>', 'gt')
utils.map('n', '<S-Tab>', 'gT')
utils.map('n', '<S-r>', ':tabnew<CR>')
utils.map('n', '<A-1>', '1gt')
utils.map('n', '<A-2>', '2gt')
utils.map('n', '<A-3>', '3gt')
utils.map('n', '<A-4>', '4gt')
utils.map('n', '<A-5>', '5gt')
utils.map('n', '<A-6>', '6gt')
utils.map('n', '<A-7>', '7gt')
utils.map('n', '<A-8>', '8gt')
utils.map('n', '<A-9>', '9gt')
utils.map('n', '<A-0>', '10gt')

-- maintain visual mode after shifting > and <
utils.map('v', '<', '<gv')
utils.map('v', '>', '>gv')
utils.map('v', '<S-h>', '<gv')
utils.map('v', '<S-l>', '>gv')
utils.map('v', 'J', ":m '>+1<CR>gv=gv")
utils.map('v', 'K', ":m '<-2<CR>gv=gv")

-- fzf
utils.map('n', '<Leader>t', ':Files<CR>')
utils.map('n', '<Leader>b', ':Buffers<CR>')
-- utils.map("n", "<leader>f", ":FzfUnstaged<CR>", { noremap = true, silent = true })
utils.map('n', '<Leader>s', ':Rg<CR>')

-- nerdcommenter
utils.map('', '<Leader>/', ':call NERDComment(0,"toggle")<CR>')

-- remove highlight
utils.map('n', '<esc>', ':noh<return><esc>')

-- tree
utils.map("n", "<Leader><Tab>", ":Neotree toggle<CR>")

-- diagnostics
utils.map("n", "<A-k>", ":lua vim.diagnostic.goto_prev()<CR>")
utils.map("n", "<A-j>", ":lua vim.diagnostic.goto_next()<CR>")

-- show unstaged files
