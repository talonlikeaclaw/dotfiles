-- using lazy.nvim
return {
  'S1M0N38/love2d.nvim',
  cmd = 'LoveRun',
  opts = {
    path_to_love_bin = '/Applications/love.app/Contents/MacOS/love',
    path_to_love_library = vim.fn.globpath(vim.o.runtimepath, "love2d/library"),
    restart_on_save = false,
  },
  keys = {
    { '<leader>v',  ft = 'lua',          desc = 'LÖVE' },
    { '<leader>vv', '<cmd>LoveRun<cr>',  ft = 'lua',   desc = 'Run LÖVE' },
    { '<leader>vs', '<cmd>LoveStop<cr>', ft = 'lua',   desc = 'Stop LÖVE' },
  },
}
