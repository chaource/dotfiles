return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = "all",
        sync_install = false,
        ignore_install = { "phpdoc" },
        highlight = {
          enable = true,
          disable = { "markdown" },
          additional_vim_regex_highlighting = false,
        },
      }
    end,
  },
  { "nvim-treesitter/playground" },
}
