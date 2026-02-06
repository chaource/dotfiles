return {
  {
    "junegunn/fzf",
  },
  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
    init = function()
      vim.g.fzf_layout = { down = "40%" }
    end,
  },
}
