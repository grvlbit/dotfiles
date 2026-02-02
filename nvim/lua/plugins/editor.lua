return {
  { -- Bufferline plugin
    'akinsho/bufferline.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require("bufferline").setup({})
    end,
  },

  { -- Terminal inside nvim
    'akinsho/toggleterm.nvim',
    lazy = true,
    keys = {
      {'<leader>t', '<cmd>ToggleTerm<cr>', desc = 'Toggle terminal'}
    },
    config = function()
      require'toggleterm'.setup({
        open_mapping = [[<leader>t]],
        direction = 'float'
      })
    end,
  },

  { 'nvim-mini/mini.bufremove',
    version = '*',
    lazy = true,
    keys = {
      {'<leader>bd', function() require("mini.bufremove").delete(0, false) end, desc = '[B]uffer [D]elete'},
      {'<leader>bD', function() require("mini.bufremove").delete(0, true) end, desc = '[B]uffer [D]elete (Force)'}
    },
    config = function()
      require("mini.bufremove").setup({})
    end,
  },
  { 'nvim-mini/mini.pairs',
    version = '*',
    event = 'InsertEnter',
    lazy = true,
    config = function()
      require("mini.pairs").setup({
      })
    end,
  },
  { 'nvim-mini/mini.trailspace',
    version = '*',
    config = function()
      require("mini.trailspace").setup{}
    end,
  },
  { 'nvim-mini/mini.icons', version = '*' },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {}},
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts={},
    cmd = "Trouble",
    keys = {
      {"<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)"}
    },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  -- lazy.nvim
  {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    -- add any options here
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
    },
  config = function()
    require("noice").setup({
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    })
  end
  },
  {
  url = 'https://codeberg.org/andyg/leap.nvim',
  config = function()
    -- set keymaps inside the config function
    vim.keymap.set({'n', 'x', 'o'}, 's',  '<Plug>(leap-forward)')
    vim.keymap.set({'n', 'x', 'o'}, 'S',  '<Plug>(leap-backward)')
    vim.keymap.set('n',             'gs', '<Plug>(leap-from-window)')
  end
  },

  -- Adds git related signs to the gutter, as well as utilities for managing changes
  { 'lewis6991/gitsigns.nvim',
    opts = {},
    config = function()
      require('gitsigns').setup({
	on_attach = function(bufnr)
	  local gs = package.loaded.gitsigns

	  local function map(mode, l, r, opts)
	    opts = opts or {}
	    opts.buffer = bufnr
	    vim.keymap.set(mode, l, r, opts)
	  end

	  -- Actions
	  map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
	  map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
	  map('n', '<leader>hS', gs.stage_buffer)
	  map('n', '<leader>ha', gs.stage_hunk)
	  map('n', '<leader>hu', gs.undo_stage_hunk)
	  map('n', '<leader>hp', gs.preview_hunk)
	  map('n', '<leader>hb', gs.toggle_current_line_blame)
	  map('n', '<leader>hD', function() gs.diffthis('~') end)
	  map('n', '<leader>hd', gs.toggle_deleted)


	end
      })
    end
  },
  { -- Add file tree plugin to navigate
    'nvim-tree/nvim-tree.lua',
    lazy = true,
    keys = {
      {'<leader>n', ':NvimTreeToggle<CR>', desc = 'Toggle file tree'}
    },
    config = function()
      require("nvim-tree").setup{
          renderer = {
            indent_markers = {
              enable = true,
            }
          }
      }
      end,
  },

  { "nvim-tree/nvim-web-devicons",
    lazy = true
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim',
    opts = {},
  },

  -- Git related plugins
  { 'tpope/vim-fugitive',
    dependencies = { 'tpope/vim-rhubarb' },
  },
  { 'tpope/vim-surround',
  },

  -- Detect tabstop and shiftwidth automatically
  { 'tpope/vim-sleuth'},

  -- Pain-free pane navigation with nvim and tmux
  {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
    { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
    { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
    { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
    { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
  },
  },

  {
  "olimorris/codecompanion.nvim",
  opts = {},
  keys = {
    { "<leader>cc", "<cmd>CodeCompanionChat<cr>", desc = "Code Companion" },
	},
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/mcphub.nvim",
    },
  config = function()
    require("codecompanion").setup({
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            -- MCP Tools
            make_tools = true,              -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
            show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
            add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
            show_result_in_chat = true,      -- Show tool results directly in chat buffer
            format_tool = nil,               -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
            -- MCP Resources
            make_vars = true,                -- Convert MCP resources to #variables for prompts
            -- MCP Prompts
            make_slash_commands = true,      -- Add MCP prompts as /slash commands
          }
        }
      }
    })
    end
  },

  {
    'ravitemer/mcphub.nvim',
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    build = "npm install -g mcp-hub@latest",  -- Installs `mcp-hub` node binary globally
    config = function()
        require("mcphub").setup()
    end
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    ft = { "markdown", "codecompanion" }
  },
}
