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
    config = function(_, opts)
      require("lualine").setup(vim.tbl_deep_extend("force", opts, {
        sections = {
          lualine_z = {
            {
              -- Shows the currently connected server and its status
              require("opencode").statusline,
            },
          },
        },
      }))
    end,
  },
}
