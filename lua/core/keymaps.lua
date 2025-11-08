local opts = { noremap = true, silent = true }

-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Move lines in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Moves lines down in visual selection' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Moves lines up in visual selection' })

vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Move down in buffer with cursor centered' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Move up in buffer with cursor centered' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Move to next match with cursor centered' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Move to previous match with cursor centered' })

-- Keep visual selection after < and > keys
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Enhance pasting
-- Paste without replacing clipboard content
vim.keymap.set('x', '<leader>p', [["_dP]])

-- do not loose yanked text after pasting over something else
vim.keymap.set('v', 'p', '"_dp', opts)

-- leader d delete wont remember as yanked/clipboard when deletes pasting
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]], { desc = 'Delete without updating paste buffer' })
--
-- prevent x delete from registering when next paste
vim.keymap.set('n', 'x', '"_x', opts)

-- Clear highlights on search when pressing <Esc> or <C-c> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-c>', '<cmd>nohlsearch<CR>')

-- Replace the word cursor is on globally
vim.keymap.set('n', '<leader>r', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Replace word cursor is on globally' })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Highlight when yanking (copying) text
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Split management
vim.keymap.set('n', '<leader>wv', '<C-w>v', { desc = 'Split window vertically' })
-- split window vertically
vim.keymap.set('n', '<leader>wh', '<C-w>s', { desc = 'Split window horizontally' })
-- split window horizontally
vim.keymap.set('n', '<leader>we', '<C-w>=', { desc = 'Make splits equal size' }) -- make split windows equal width & height
-- close current split window
vim.keymap.set('n', '<leader>wx', '<cmd>close<CR>', { desc = 'Close current split' })

-- Toggle LSP diagnostics visibility
local isLspDiagnosticsVisible = true
vim.keymap.set('n', '<leader>lx', function()
  isLspDiagnosticsVisible = not isLspDiagnosticsVisible
  vim.diagnostic.config {
    virtual_text = isLspDiagnosticsVisible,
    underline = isLspDiagnosticsVisible,
  }
end, { desc = 'Toggle LSP diagnostics' })
