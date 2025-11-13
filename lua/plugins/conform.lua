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
      format_on_save = function(bufnr)
        local ft = vim.bo[bufnr].filetype
        if ft == 'xml' then
          return
        end
        return {
          lsp_format = 'fallback',
          timeout_ms = 500,
        }
      end,
    }
  end,
}
