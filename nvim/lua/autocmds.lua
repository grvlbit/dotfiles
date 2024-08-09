-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Automatically set text width for markdown files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "markdown" },
  command = "set tw=80",
})

-- Empty formatexpr for markdown files to make gqq and gqap work again
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "markdown", "gitcommit" },
  command = "set formatexpr=",
})

-- Markdown should have wrapping enabled by default
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "markdown" },
  command = "set wrap",
})

-- INFO: This is the default nvim colorscheme
vim.cmd.colorscheme 'habamax'
