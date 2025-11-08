-- See `:help gitsigns` to understand what the configuration keys do
return { -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
      end

      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal { ']c', bang = true }
        else
          gs.nav_hunk 'next'
        end
      end, 'Jump to next git [c]hange')

      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          gs.nav_hunk 'prev'
        end
      end, 'Jump to previous git [c]hange')

      map('n', '<leader>gp', gs.next_hunk, 'git [p]review hunk')
      map('n', '<leader>gp', gs.preview_hunk, 'git [p]review hunk')
      map('n', '<leader>gb', gs.blame_line, 'git [b]lame line')
      map('n', '<leader>gd', gs.diffthis, 'git [d]iff against index')
      map('n', '<leader>gb', gs.toggle_current_line_blame, '[T]oggle git show [b]lame line')
      map('n', '<leader>gD', gs.preview_hunk_inline, '[T]oggle git show [D]eleted')
    end,
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
  },
}
