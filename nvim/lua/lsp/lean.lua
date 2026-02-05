-- More tools may be available (check github)
require('lean').setup({
  event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  ---@type lean.Config
  opts = {
    mappings = true,
  },
	mappings = true,
})
