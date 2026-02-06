local utils = require('utils')

local function nvim_create_augroups(groups)
	for group_name, definition in pairs(groups) do
		vim.api.nvim_create_augroup(group_name, { clear = true })
		for _, def in ipairs(definition) do
			local opts = def.opts
			opts.group = group_name
			vim.api.nvim_create_autocmd(def.event, opts)
		end
	end
end

local augroups = {
	packer = {
		{
			event = "BufWritePost",
			opts = {
				pattern = "plugins.lua",
				command = "PackerCompile"
			}
		};
	};
	restore_cursor = {
		{
			event = 'BufRead',
			opts = {
				pattern = '*',
				command = [[call setpos(".", getpos("'\""))]]
			}
		};
	};
	autoformat = {
		{
			event = 'BufWritePre',
			opts = {
				pattern = { '*.rs', '*.lua' },
				callback = function()
					vim.lsp.buf.format()
				end
			}
		};
	};
}

nvim_create_augroups(augroups)

-- open nvim-tree for folders
-- local function open_nvim_tree(data)

--     -- buffer is a directory
--     local directory = vim.fn.isdirectory(data.file) == 1

--     if not directory then
--         return
--     end

--     -- change to the directory
--     vim.cmd.cd(data.file)

--     -- open the tree
--     require("nvim-tree.api").tree.open()
-- end

-- vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
