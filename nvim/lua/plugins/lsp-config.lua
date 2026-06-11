return {
  { "mason-org/mason.nvim", opts = {} },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
  },
  { "j-hui/fidget.nvim", opts = {} },
  {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = { 'rafamadriz/friendly-snippets' },

  -- use a release tag to download pre-built binaries
  version = '1.*',
  opts = {
    keymap = { preset = 'default' },

    appearance = {
      nerd_font_variant = 'mono'
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = { documentation = { auto_show = false } },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    fuzzy = { implementation = "prefer_rust" }
  },
  opts_extend = { "sources.default" },
  config = function(_, opts)
    local blink = require('blink.cmp')
    blink.setup(opts)

    -- Advertise extended LSP capabilities (richer completion items, snippets, etc.)
    vim.lsp.config('*', {
      capabilities = blink.get_lsp_capabilities(),
    })
  end,
  },

  -- LSP keymaps — set buffer-locally whenever a server attaches
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    init = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspAttach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gd',         vim.lsp.buf.definition,       'Go to [D]efinition')
          map('gD',         vim.lsp.buf.declaration,      'Go to [D]eclaration')
          map('gr',         vim.lsp.buf.references,       'Go to [R]eferences')
          map('gi',         vim.lsp.buf.implementation,   'Go to [I]mplementation')
          map('gy',         vim.lsp.buf.type_definition,  'Go to T[y]pe Definition')
          map('K',          vim.lsp.buf.hover,            'Hover documentation')
          map('<leader>rn', vim.lsp.buf.rename,           '[R]e[n]ame symbol')
          map('<leader>ca', vim.lsp.buf.code_action,      '[C]ode [A]ction')
          map('<leader>f',  function() vim.lsp.buf.format({ async = true }) end, '[F]ormat buffer')
        end,
      })
    end,
  },
}
