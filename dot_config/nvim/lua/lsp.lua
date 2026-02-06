-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	--buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	--buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	--buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	--buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	--buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
	buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
	--buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
	--buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- godot
vim.lsp.config.gdscript = {
	capabilities = capabilities,
	on_attach = on_attach,
	flags = {
		debounce_text_changes = 150,
	}
}

-- rust
vim.lsp.config.rust_analyzer = {
	capabilities = capabilities,
	on_attach = on_attach,
	flags = {
		debounce_text_changes = 150,
	},
	settings = {
		["rust-analyzer"] = {
			diagnostics = {
				disabled = { "unresolved-import" }
			},
			cargo = {
				loadOutDirsFromCheck = true
			},
			procMacro = {
				enable = true
			},
			checkOnSave = {
				command = "clippy"
			},
		}
	}
}

-- python
vim.lsp.config.pyright = {
	capabilities = capabilities,
	on_attach = on_attach,
	flags = {
		debounce_text_changes = 150,
	}
}

-- typescript
-- vim.lsp.config.tsserver = {
--     capabilities = capabilities,
--     on_attach = function(client, bufnr)
--         client.server_capabilities.document_formatting = false
--         on_attach(client, bufnr)
--     end,
--     flags = {
--         debounce_text_changes = 150,
--     }
-- }

-- lua
vim.lsp.config.lua_ls = {
	capabilities = capabilities,
	on_attach = on_attach,
	flags = {
		debounce_text_changes = 150,
	},
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim', 'use' },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
}

vim.lsp.config.vuels = {
	capabilities = capabilities,
	on_attach = on_attach,
	flags = {
		debounce_text_changes = 150,
	}
}

-- wgsl
vim.lsp.config.wgsl_analyzer = {
	capabilities = capabilities,
	on_attach = on_attach,
	flags = {
		debounce_text_changes = 150,
	}
}

-- Enable the configured language servers
vim.lsp.enable('gdscript')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('pyright')
vim.lsp.enable('lua_ls')
vim.lsp.enable('vuels')
vim.lsp.enable('wgsl_analyzer')

-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
-- require("null-ls").setup({
--     capabilities = capabilities,
--     flags = {
--         debounce_text_changes = 150,
--     },
--     sources = {
--         require("null-ls").builtins.formatting.prettier,
--     },

--     -- you can reuse a shared lspconfig on_attach callback here
--     on_attach = function(client, bufnr)
--         if client.supports_method("textDocument/formatting") then
--             vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
--             vim.api.nvim_create_autocmd("BufWritePre", {
--                 group = augroup,
--                 buffer = bufnr,
--                 callback = function()
--                     -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
--                     vim.lsp.buf.formatting_sync()
--                 end,
--             })
--         end
--     end,
-- })
