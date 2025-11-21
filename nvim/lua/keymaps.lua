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
vim.opt.ignorecase=true
vim.opt.smartcase=true
vim.opt.showmatch=true

-- Spell checking
vim.opt.spelllang = { "en", "de" }
vim.opt.spell = true

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
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

-- Default custom filetypes
vim.filetype.add({
  extension = {
    yml = "yaml.ansible",
    yaml = "yaml.ansible"
  }
})

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- You can't stop me
vim.keymap.set('c', 'w!!', 'w !sudo tee %')

-- Map paste mode toggle to something useful
vim.keymap.set('n', '<leader>p', ':set paste!<CR>')

-- Remap the ESC key for quicker escaping
vim.keymap.set('i', 'jj', '<ESC>')

-- TAB in general mode will move to text buffer
vim.keymap.set('n', '<TAB>', ':bnext<CR>')
-- SHIFT-TAB will go back
vim.keymap.set('n', '<S-TAB>', ':bprevious<CR>')

-- For keeping search results centered
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', 'J', 'mzJ`z')

-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Use alt + hjkl to resize windows
vim.keymap.set('n', '<M-j>', ':resize +2<CR>')
vim.keymap.set('n', '<M-k>', ':resize -2<CR>')
vim.keymap.set('n', '<M-h>', ':vertical resize +2<CR>')
vim.keymap.set('n', '<M-l>', ':vertical resize -2<CR>')

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Open journal file in new buffer and set it to markdown
local function get_journal_filename()
  return 'journal-' .. os.date('%Y-%m-%d') .. '.md'
end
vim.keymap.set('n', '<leader>j', ":edit " .. "~/journal/" .. get_journal_filename() .. "<cr>", {})

-- Diagnostic keymaps
vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to previous diagnostic message" })

vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to next diagnostic message" })

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
