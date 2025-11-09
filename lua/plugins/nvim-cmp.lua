return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  enable = true,
  branch = 'main', -- fix for deprecated functions coming in nvim 0.13
  dependencies = {
    'hrsh7th/cmp-buffer', -- source for text in buffer
    'hrsh7th/cmp-path', -- source for file system paths
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      build = (function()
        return 'make install_jsregexp'
      end)(),
      opts = {},
    },
  },
  config = function()
    local cmp = require 'cmp'
    cmp.setup {
      completion = {
        completeopt = 'menu,menuone,noinsert',
      },
      window = {
        documentation = {
          border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
        },
        completion = {
          border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
        },
      },

      -- autocompletion sources
      sources = cmp.config.sources {
        { name = 'nvim_lsp' },
        { name = 'buffer' }, -- text within current buffer
        { name = 'path' }, -- file system paths
        {
          name = 'spell', -- for markdown spellchecks completions
          option = {
            enable_in_context = function()
              local ft = vim.bo.filetype
              return ft == 'markdown' or ft == 'text'
            end,
          },
        },
      },
    }
  end,
}
