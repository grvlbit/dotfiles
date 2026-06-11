-- Set <,> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

vim.opt.splitbelow=true                  -- Horizontal splits will automatically be below
vim.opt.splitright=true                  -- Vertical splits will automatically be to the right
vim.opt.cursorline=true                  -- Highlights current line number
vim.opt.cursorlineopt="number"           -- Hightlights only line number not whole line
vim.opt.relativenumber = true            -- Enable relative line numbers

-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.showmatch = true

-- Spell checking — deferred to file open to avoid loading dictionaries at startup
vim.api.nvim_create_autocmd('BufReadPost', {
  once = true,
  callback = function()
    vim.opt.spelllang = { "en", "de" }
    vim.opt.spell = true
  end,
})

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Local Python
local conda_home = os.getenv("CONDA_HOME")
if conda_home ~= nil then
  -- Concatenate the string to conda_home
  vim.g.python3_host_prog= conda_home .. "/bin/python"
end

-- Map common Ansible directory structures to yaml.ansible filetype.
-- Using path patterns avoids misclassifying Kubernetes, GH Actions, docker-compose, etc.
vim.filetype.add({
  pattern = {
    ['.*/roles/.+%.ya?ml']      = 'yaml.ansible',
    ['.*/playbooks/.+%.ya?ml']  = 'yaml.ansible',
    ['.*/tasks/.+%.ya?ml']      = 'yaml.ansible',
    ['.*/handlers/.+%.ya?ml']   = 'yaml.ansible',
    ['.*/defaults/.+%.ya?ml']   = 'yaml.ansible',
    ['.*/vars/.+%.ya?ml']       = 'yaml.ansible',
    ['.*/group_vars/.+%.ya?ml'] = 'yaml.ansible',
    ['.*/host_vars/.+%.ya?ml']  = 'yaml.ansible',
    ['.*playbook.*%.ya?ml']     = 'yaml.ansible',
  },
})

-- [[ Basic Keymaps ]]

-- Remap the ESC key for quicker escaping
vim.keymap.set('i', 'jj', '<ESC>')

-- You can't stop me
vim.keymap.set('c', 'w!!', 'w !sudo tee %')

-- TAB in general mode will move to text buffer
vim.keymap.set('n', '<TAB>', ':bnext<CR>')
-- SHIFT-TAB will go back
vim.keymap.set('n', '<S-TAB>', ':bprevious<CR>')

-- For keeping search results centered
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', 'J', 'mzJ`z')

-- Use alt + hjkl to resize windows
vim.keymap.set('n', '<M-j>', ':resize +2<CR>')
vim.keymap.set('n', '<M-k>', ':resize -2<CR>')
vim.keymap.set('n', '<M-h>', ':vertical resize +2<CR>')
vim.keymap.set('n', '<M-l>', ':vertical resize -2<CR>')

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Open journal file in new buffer and set it to markdown
vim.keymap.set('n', '<leader>j', function()
  local filename = 'journal-' .. os.date('%Y-%m-%d') .. '.md'
  vim.cmd("edit ~/journal/" .. filename)
end, { desc = "Open today's journal" })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to previous diagnostic message" })

vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to next diagnostic message" })

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })

-- Strip trailing whitespace
vim.keymap.set("n", "<leader>w", ":%s/\\s\\+$//e<CR>", { silent = true })

