-- sensible defaults
local utils = require('utils')

local cmd = vim.cmd
local indent = 4

cmd 'set foldmethod=marker'

-- theme
cmd 'syntax on'
cmd 'syntax enable'
cmd 'filetype plugin indent on'
cmd 'filetype plugin on'
utils.opt('o', 'background', 'dark')
utils.opt('w', 'colorcolumn', '80')
utils.opt('w', 'number', true)
utils.opt('o', 'termguicolors', true)
vim.g.gruvbox_material_background = 'dark'
vim.g.loaded_netrwplugin = 1
vim.opt.termguicolors = true

cmd 'set mouse='

-- relative number in insert mode
cmd 'autocmd InsertEnter * :set nonumber relativenumber'
cmd 'autocmd InsertLeave * :set number norelativenumber'

-- system shared clipboard
cmd 'set clipboard+=unnamedplus'
utils.opt('w', 'wrap', false)
utils.opt('b', 'tabstop', indent)
utils.opt('b', 'shiftwidth', indent)
utils.opt('b', 'smartindent', true)
utils.opt('b', 'autoindent', true)
utils.opt('o', 'showmatch', true)
utils.opt('o', 'splitright', true)

-- show invisibles
utils.opt('w', 'list', true)
utils.opt('w', 'listchars', 'tab:‣ ,trail:~,extends:>,precedes:<')

-- abbreviations
cmd 'noreabbrev W! w!'
cmd 'noreabbrev Q! q!'
cmd 'noreabbrev Qall! qall!'
cmd 'noreabbrev Wq wq'
cmd 'noreabbrev Wa wa'
cmd 'noreabbrev wQ wq'
cmd 'noreabbrev WQ wq'
cmd 'noreabbrev W w'
cmd 'noreabbrev Q q'
cmd 'noreabbrev Qa qa'
cmd 'noreabbrev Qa! qa!'
cmd 'noreabbrev Qall qall'
cmd "autocmd FileType glsl let &l:commentstring='// %s'"
