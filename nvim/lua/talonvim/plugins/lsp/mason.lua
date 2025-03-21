return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },

  config = function()
    local mason = require 'mason'
    local mason_lspconfig = require 'mason-lspconfig'
    local mason_tool_installer = require 'mason-tool-installer'
    mason.setup {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
        border = 'double',
        width = 0.8,
        height = 0.8,
      },
      registries = {
        'github:nvim-java/mason-registry',
        'github:mason-org/mason-registry',
      },
    }

    -- mason-lspconfig
    mason_lspconfig.setup {
      ensure_installed = {
        'lua_ls',
        'cssls',
        'marksman',
        'eslint',
        'ts_ls',
        'pylsp',
      },
      -- auto installation
      automatic_installation = true,
    }

    -- mason-tool-installer
    mason_tool_installer.setup {
      ensure_installed = {
        -- you can turn off/on auto_update per tool
        { 'bash-language-server' },
        { 'lua-language-server' },
        { 'vim-language-server' },
        { 'stylua' },
        { 'editorconfig-checker' },
        { 'html-lsp' },
        { 'emmet-ls' },
        { 'css-lsp' },
        { 'prettier' },
        { 'pylsp' },
        { 'black' },
      },

      auto_update = true,
      run_on_start = true,
      start_delay = 3000, -- 3 second delay
      debounce_hours = 5, -- at least 5 hours between attempts to install/update
    }
  end,
}
