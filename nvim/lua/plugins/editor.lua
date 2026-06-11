return {
  { -- Bufferline plugin
    'akinsho/bufferline.nvim',
    dependencies = { 'nvim-mini/mini.icons' },
    config = function()
      require("bufferline").setup({})
    end,
  },

  {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    bufdelete = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    gitbrowse = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    lazygit = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    picker = {
      enabled = true,
      actions = {
        opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
      },
      win = {
        input = {
          keys = {
            ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
          },
        },
      },
    },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    terminal = {
      enabled = true,
      win = {
        style    = "float",
        border   = "rounded",
        width    = 0.8,
        height   = 0.8,
        relative = "editor",
      },
    },
  },
  config = function(_, opts)
    require("snacks").setup(opts)

    -- Terminal toggle
    vim.keymap.set({ "n", "t" }, "<leader>t", function()
      Snacks.terminal.toggle()
    end, { desc = "Toggle terminal" })

    -- File explorer toggle (replaces nvim-tree)
    vim.keymap.set("n", "<leader>n", function()
      Snacks.explorer()
    end, { desc = "Toggle file explorer" })

    -- Picker keymaps (replacing Telescope)
    vim.keymap.set("n", "<leader>?",       function() Snacks.picker.recent() end,        { desc = "[?] Find recently opened files" })
    vim.keymap.set("n", "<leader><space>", function() Snacks.picker.buffers() end,       { desc = "[ ] Find existing buffers" })
    vim.keymap.set("n", "<leader>/",       function() Snacks.picker.lines() end,         { desc = "[/] Fuzzily search in current buffer" })
    vim.keymap.set("n", "<leader>sf",      function() Snacks.picker.files() end,         { desc = "[S]earch [F]iles" })
    vim.keymap.set("n", "<leader>sh",      function() Snacks.picker.help() end,          { desc = "[S]earch [H]elp" })
    vim.keymap.set("n", "<leader>sw",      function() Snacks.picker.grep_word() end,     { desc = "[S]earch current [W]ord" })
    vim.keymap.set("n", "<leader>sg",      function() Snacks.picker.grep() end,          { desc = "[S]earch by [G]rep" })
    vim.keymap.set("n", "<leader>sd",      function() Snacks.picker.diagnostics() end,   { desc = "[S]earch [D]iagnostics" })
    vim.keymap.set("n", "<leader>st",      function() Snacks.picker.todo_comments() end,  { desc = "[S]earch [T]ODOs" })
    vim.keymap.set("n", "<leader>sr",      function() Snacks.picker.resume() end,         { desc = "[S]earch [R]esume last picker" })

    -- Git keymaps (snacks.lazygit + snacks.gitbrowse)
    vim.keymap.set("n", "<leader>gg",      function() Snacks.lazygit() end,              { desc = "Open Lazygit" })
    vim.keymap.set("n", "<leader>gl",      function() Snacks.lazygit.log() end,          { desc = "Lazygit log" })
    vim.keymap.set("n", "<leader>gL",      function() Snacks.lazygit.log_file() end,     { desc = "Lazygit log (current file)" })
    vim.keymap.set("n", "<leader>gB",      function() Snacks.gitbrowse() end,            { desc = "Git browse (open in browser)" })

    -- Buffer delete (replaces mini.bufremove)
    vim.keymap.set("n", "<leader>bd",      function() Snacks.bufdelete() end,            { desc = "[B]uffer [D]elete" })
    vim.keymap.set("n", "<leader>bD",      function() Snacks.bufdelete({ force = true }) end, { desc = "[B]uffer [D]elete (Force)" })
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
  { 'nvim-mini/mini.icons',
    version = '*',
    lazy = false,
    priority = 900,
    config = function()
      require("mini.icons").setup()
      -- Shim nvim-web-devicons so dependent plugins (bufferline, trouble, etc.) get mini.icons
      require("mini.icons").mock_nvim_web_devicons()
    end,
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {}},
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

	  -- Navigation
	  map('n', ']h', gs.next_hunk, { desc = 'Next hunk' })
	  map('n', '[h', gs.prev_hunk, { desc = 'Previous hunk' })

	  -- Actions
	  map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
	  map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
	  map('n', '<leader>hS', gs.stage_buffer)
	  map('n', '<leader>hu', gs.undo_stage_hunk)
	  map('n', '<leader>hp', gs.preview_hunk)
	  map('n', '<leader>hb', gs.toggle_current_line_blame)
	  map('n', '<leader>hD', function() gs.diffthis('~') end)
	  map('n', '<leader>hd', gs.toggle_deleted)


	end
      })
    end
  },
  -- "gc" to comment visual regions/lines — built into Neovim 0.10+, no plugin needed

  { 'tpope/vim-surround' },

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
  init = function()
    -- Set terminal-mode navigation keymaps early so lazy-loading triggers on first use.
    -- These are overridden in `config` after the plugin loads with the same mappings,
    -- which ensures the plugin's own tnoremap doesn't win.
    vim.keymap.set("t", "<C-h>", "<C-\\><C-n><cmd>TmuxNavigateLeft<cr>")
    vim.keymap.set("t", "<C-j>", "<C-\\><C-n><cmd>TmuxNavigateDown<cr>")
    vim.keymap.set("t", "<C-k>", "<C-\\><C-n><cmd>TmuxNavigateUp<cr>")
    vim.keymap.set("t", "<C-l>", "<C-\\><C-n><cmd>TmuxNavigateRight<cr>")
  end,
  config = function()
    -- Re-apply after plugin loads to override the plugin's own `tnoremap` (<C-w>: variant).
    vim.keymap.set("t", "<C-h>", "<C-\\><C-n><cmd>TmuxNavigateLeft<cr>")
    vim.keymap.set("t", "<C-j>", "<C-\\><C-n><cmd>TmuxNavigateDown<cr>")
    vim.keymap.set("t", "<C-k>", "<C-\\><C-n><cmd>TmuxNavigateUp<cr>")
    vim.keymap.set("t", "<C-l>", "<C-\\><C-n><cmd>TmuxNavigateRight<cr>")
  end,
  },

  {
  "nickjvandyke/opencode.nvim",
  version = "*",
  config = function()
    local function remap_path(value)
      if not value then return nil end
      return (value:gsub(vim.pesc(vim.fn.getcwd()), "/workspace"))
    end

    --local opencode_cmd = 'opencode --port'
    local opencode_cmd = "zsh -i -c 'occ'"
    ---@type snacks.terminal.Opts
    local snacks_terminal_opts = {
      win = {
        position = 'right',
        enter = false,
      },
    }

    ---@type opencode.Opts
    vim.g.opencode_opts = {
      server = {
        -- occ runs opencode in a Docker container with port 4096 mapped to localhost
        url = "http://localhost:4096",
        start = function()
          local win = require('snacks.terminal').get(opencode_cmd, { create = false })
          if win then
            win:show()
          else
            require('snacks.terminal').open(opencode_cmd, snacks_terminal_opts)
          end
        end,
      },
      contexts = {
        ["@this"]        = function(ctx) return remap_path(require("opencode.context.builtins").this(ctx)) end,
        ["@buffer"]      = function(ctx) return remap_path(require("opencode.context.builtins").buffer(ctx)) end,
        ["@buffers"]     = function(_)   return remap_path(require("opencode.context.builtins").buffers()) end,
        ["@visible"]     = function(_)   return remap_path(require("opencode.context.builtins").visible_text()) end,
        ["@diagnostics"] = function(ctx) return remap_path(require("opencode.context.builtins").diagnostics(ctx)) end,
        ["@quickfix"]    = function(_)   return remap_path(require("opencode.context.builtins").quickfix()) end,
        ["@diff"]        = function(_)   return require("opencode.context.builtins").git_diff() end,
        ["@marks"]       = function(_)   return remap_path(require("opencode.context.builtins").marks()) end,
      },
    }

    vim.o.autoread = true

    vim.keymap.set({ "n", "x" }, "<leader>oa", function() require("opencode").ask("@this: ") end,           { desc = "Ask opencode…" })
    vim.keymap.set({ "n", "x" }, "<leader>os", function() require("opencode").select() end,                  { desc = "Select opencode…" })
    vim.keymap.set({ "n", "x" }, "go",  function() return require("opencode").operator("@this ") end,        { desc = "Add range to opencode", expr = true })
    vim.keymap.set("n",          "goo", function() return require("opencode").operator("@this ") .. "_" end, { desc = "Add line to opencode", expr = true })
    vim.keymap.set("n", "<leader>ou", function() require("opencode").command("session.half.page.up") end,   { desc = "Scroll opencode up" })
    vim.keymap.set("n", "<leader>od", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll opencode down" })

    -- Toggle opencode terminal (avoid <leader> in terminal mode to prevent input delay)
    vim.keymap.set({ 'n', 't' }, '<C-.>', function()
      require('snacks.terminal').toggle(opencode_cmd, snacks_terminal_opts)
    end, { desc = 'Toggle opencode' })

    -- Show terminal when a prompt is submitted
    vim.api.nvim_create_autocmd('User', {
      pattern = { 'OpencodeEvent:tui.command.execute' },
      callback = function(args)
        ---@type opencode.server.Event
        local event = args.data.event
        if event.properties.command == 'prompt.submit' then
          local win = require('snacks.terminal').get(opencode_cmd, { create = false })
          if win then
            win:show()
          end
        end
      end,
    })
  end,
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    ft = { "markdown", "codecompanion" }
  },
}
