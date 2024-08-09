return {
  { -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = true,
        --theme = 'gruvbox', -- onedark
        theme = 'auto', -- onedark
      },
    },
  },
}
