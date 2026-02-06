return {
  { "nvim-lua/plenary.nvim" },
  { "DingDean/wgsl.vim" },
  {
    "nmac427/guess-indent.nvim",
    config = function()
      require("guess-indent").setup {}
    end
  }
}
