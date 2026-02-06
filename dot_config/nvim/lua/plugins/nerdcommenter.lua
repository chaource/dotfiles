return {
  "ddollar/nerdcommenter",
  init = function()
    vim.cmd [[let g:NERDCustomDelimiters = { 'wgsl': { 'left': '//' } }]]
  end
}
