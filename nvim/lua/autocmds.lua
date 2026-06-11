-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.hl.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Automatically set text width, format expression, and wrapping for markdown files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.textwidth  = 80
    vim.opt_local.wrap       = true
    vim.opt_local.formatexpr = ""
  end,
})

-- Empty formatexpr for gitcommit so gqq/gqap work correctly
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function()
    vim.opt_local.formatexpr = ""
  end,
})

-- INFO: This is the default nvim colorscheme
-- vim.cmd.colorscheme 'habamax'
