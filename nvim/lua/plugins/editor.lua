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

  { 'echasnovski/mini.bufremove',
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
  { 'echasnovski/mini.pairs',
    version = '*',
    event = 'InsertEnter',
    lazy = true,
    config = function()
      require("mini.pairs").setup({})
    end,
  },
  { 'echasnovski/mini.trailspace',
    version = '*',
    config = function()
      require("mini.trailspace").setup{}
    end,
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {}},
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = true,
    keys = {
      {"<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Toggle trouble"}
    },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { 'ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings()
    end,
  },

  -- Adds git releated signs to the gutter, as well as utilities for managing changes
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

  { 'ThePrimeagen/vim-be-good',
    cmd = 'VimBeGood',
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
}

}
