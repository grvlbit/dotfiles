return {
  -- Highlight, edit, and navigate code
  { 'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'bash', 'json', 'jsonc', 'lua', 'markdown', 'markdown_inline',
          'python', 'toml', 'yaml',
        },
        highlight = { enable = true },
        indent    = { enable = true },
      })
    end,
  },
}
