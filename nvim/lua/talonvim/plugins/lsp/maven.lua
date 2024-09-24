return {
  'eatgrass/maven.nvim',
  cmd = { 'Maven', 'MavenExec' },
  dependencies = 'nvim-lua/plenary.nvim',
  config = function()
    require('maven').setup {
      executable = '/opt/homebrew/bin/mvn',
      cwd = nil,
      settings = nil,
      commands = {
        { cmd = { 'clean', 'compile' }, desc = 'clean then compile' },
      },
    }
  end,
}
