return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local conform = require 'conform'

    conform.setup {
      formatters_by_ft = {
        javascript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescript = { 'prettier' },
        css = { 'prettier' },
        html = { 'prettier' },
        json = { 'prettier' },
        yaml = { 'prettier' },
        markdown = { 'prettier' },
        lua = { 'stylua' },
      },
      formatters = {
        prettier = {
          prepend_args = { '--print-width', '80', '--tab-width', '2' },
        },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    }
    vim.keymap.set({ 'n', 'v' }, '<leader>cf', function()
      conform.format {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      }
    end, { desc = 'format' })
  end,
}
