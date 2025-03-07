return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = true,
  },

  { 'j-hui/fidget.nvim', tag = 'legacy' , opts = {} },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {'L3MON4D3/LuaSnip', dependencies = { "rafamadriz/friendly-snippets" }, },
      {"hrsh7th/cmp-nvim-lsp"},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
    },
    config = function()
      -- Here is where you configure the autocompletion settings.
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_cmp()

      -- And you can configure cmp even more, if you want to.
      local cmp = require('cmp')
      local cmp_action = lsp_zero.cmp_action()
      local select_opts = {behavior = cmp.SelectBehavior.Select}

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        formatting = lsp_zero.cmp_format(),
        --snippet = {
        --  expand = function(args)
        --    require('luasnip').lsp_expand(args.body)
        --  end,
        --},
        --formatting = {
        --  fields = {'menu', 'abbr', 'kind'},
        --  format = function(entry, item)
        --    local menu_icon = {
        --      nvim_lsp = 'λ',
        --      luasnip = '⋗',
        --      buffer = 'Ω',
        --      path = '🖫',
        --    }
        --    item.menu = menu_icon[entry.source.name]
        --    return item
        --  end,
        --},
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-f>'] = cmp_action.luasnip_jump_forward(),
          ['<C-b>'] = cmp_action.luasnip_jump_backward(),
          ['<C-k>'] = cmp.mapping.select_prev_item(select_opts),
          ['<C-j>'] = cmp.mapping.select_next_item(select_opts),
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
        }),
        sources = {
          {name = 'nvim_lsp'},
          {name = 'luasnip'},
          {name = 'buffer'},
          {name = 'path'},
        },
      })
    end
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = {'LspInfo', 'LspInstall', 'LspStart'},
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = {
      {'hrsh7th/cmp-nvim-lsp'},
      {'williamboman/mason-lspconfig.nvim'},
    },
    opts = {
      servers = {
        -- https://github.com/microsoft/pyright/discussions/5852#discussioncomment-6874502
        pyright = {
          capabilities = {
            textDocument = {
              publishDiagnostics = {
                tagSupport = {
                  valueSet = { 2 },
                },
              },
            },
          },
        },
        ruff_lsp = {},
      },
    },
    config = function()
      -- This is where all the LSP shenanigans will live
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig()

      --- if you want to know more about lsp-zero and mason.nvim
      --- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp_zero.default_keymaps({buffer = bufnr})
      end)

      require('mason-lspconfig').setup({
        ensure_installed = {},
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            -- (Optional) Configure lua language server for neovim
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
          end,
        }
      })
    end
  }
}
