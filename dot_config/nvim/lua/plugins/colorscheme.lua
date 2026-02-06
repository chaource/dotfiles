return {
  "sainnhe/gruvbox-material",
  priority = 1000,
  config = function()
    vim.g.gruvbox_material_background = 'dark'
    vim.g.gruvbox_material_foreground = 'original'
    vim.g.gruvbox_material_better_performance = 1
    vim.g.gruvbox_material_diagnostic_line_highlight = 1
    vim.g.gruvbox_material_diagnostic_text_highlight = 1
    vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
    vim.g.gruvbox_material_enable_italic = 1
    vim.g.gruvbox_material_transparent_background = 1
    vim.cmd.colorscheme("gruvbox-material")
  end,
}
