return {
	"stevearc/conform.nvim",
	config = function()
	  require("conform").setup {
		formatters_by_ft = {
			-- Conform will run multiple formatters sequentially
			python = { "isort", "black" },
			-- You can customize some of the format options for the filetype (:help conform.format)
			rust = { "rustfmt", lsp_format = "fallback" },
			-- Conform will run the first available formatter
			javascript = { "prettier" },
			typescript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			terraform = { "tofu_fmt" },
			["_"] = { "trim_whitespace" },
		},
		format_on_save = {
		  timeout_ms = 500,
		  lsp_fallback = true,
		},
	  }
	end
}
