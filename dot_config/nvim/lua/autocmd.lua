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
	restore_cursor = {
		{
			event = 'BufRead',
			opts = {
				pattern = '*',
				command = [[call setpos(".", getpos("'\""))]]
			}
		};
	};
	markdown_settings = {
		{
			event = 'FileType',
			opts = {
				pattern = 'markdown',
				callback = function()
					vim.opt_local.conceallevel = 1
					vim.opt_local.concealcursor = ''
				end
			}
		};
	};
}

nvim_create_augroups(augroups)

vim.api.nvim_create_user_command("FzfUnstaged", function()
  local fzf_opts = {
    source = "git status --porcelain | grep '^.M' | cut -c4-",
    sink = function(line)
      if line and #line > 0 then
        vim.cmd("edit " .. line)
      end
    end,
    options = {
      "--multi",
      "--prompt=Unstaged> ",
      "--preview", "bat --style=numbers --color=always {}",
      "--preview-window", "right:60%",
    }
  }

  local wrapped = vim.fn["fzf#wrap"]("unstaged_files", fzf_opts, false)
  vim.fn["fzf#run"](wrapped)
end, {})
