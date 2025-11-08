return { -- Collection of various small independent plugins/modules
  {
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  {
    'echasnovski/mini.surround',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {

      -- Module mappings. Use `''` (empty string) to disable one.
      -- INFO:
      -- saiw surround with no whitespace
      -- saw surround with whitespace
      mappings = {
        add = 'sa', -- Add surrounding in Normal and Visual modes
        delete = 'ds', -- Delete surrounding
        find = 'sf', -- Find surrounding (to the right)
        find_left = 'sF', -- Find surrounding (to the left)
        highlight = 'sh', -- Highlight surrounding
        replace = 'cs', -- Change surrounding

        suffix_last = 'l', -- Suffix to search with "prev" method
        suffix_next = 'n', -- Suffix to search with "next" method
      },

      -- Number of lines within which surrounding is searched
      n_lines = 20,

      -- Whether to respect selection type:
      -- - Place surroundings on separate lines in linewise mode.
      -- - Place surroundings on each line in blockwise mode.
      respect_selection_type = false,

      -- How to search for surrounding (first inside current line, then inside
      -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
      -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
      -- see `:h MiniSurround.config`.
      search_method = 'cover_or_next',

      -- Whether to disable showing non-error feedback
      silent = false,
    },
  },
  -- Get rid of whitespace
  {
    'echasnovski/mini.trailspace',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      local miniTrailspace = require 'mini.trailspace'

      miniTrailspace.setup {
        only_in_normal_buffers = true,
      }
      vim.keymap.set('n', '<leader>cw', function()
        miniTrailspace.trim()
      end, { desc = 'Erase Whitespace' })

      -- Ensure highlight never reappears by removing it on CursorMoved
      vim.api.nvim_create_autocmd('CursorMoved', {
        pattern = '*',
        callback = function()
          require('mini.trailspace').unhighlight()
        end,
      })
    end,
  },
  -- Split & join
  {
    'echasnovski/mini.splitjoin',
    config = function()
      local miniSplitJoin = require 'mini.splitjoin'
      miniSplitJoin.setup {
        mappings = { toggle = '' }, -- Disable default mapping
      }
      vim.keymap.set({ 'n', 'x' }, 'sj', function()
        miniSplitJoin.join()
      end, { desc = 'Join arguments' })
      vim.keymap.set({ 'n', 'x' }, 'sk', function()
        miniSplitJoin.split()
      end, { desc = 'Split arguments' })
    end,
  },
}
