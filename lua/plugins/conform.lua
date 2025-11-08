-- Autoformat
return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile', 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format {
          async = true,
          lsp_format = 'fallback',
        }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  config = function()
    require('conform').setup {
      format_on_save = {
        lsp_format = 'fallback',
        timeout_ms = 500,
      },
    }
  end,
}
