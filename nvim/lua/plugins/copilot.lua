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
            accept = "<TAB>",
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
