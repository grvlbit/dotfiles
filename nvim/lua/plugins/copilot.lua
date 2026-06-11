return {
  { -- Github Copilot
    'zbirenbaum/copilot.lua',
    cmd = "Copilot",
      event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          auto_trigger = true,
          keymap = {
            accept     = "<TAB>",
            accept_word = "<M-w>",
            accept_line = "<M-l>",
            next       = "<M-]>",
            prev       = "<M-[>",
            dismiss    = "<C-e>",
          }
        },
        filetypes = {
          yaml = true,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          ["."] = false,
        },
        })
    end,
  },
} 
