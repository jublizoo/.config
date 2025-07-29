vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.swapfile = false
vim.o.signcolumn = "yes"
vim.g.mapleader = " "

-- Change cursor 
vim.opt.guicursor = "n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor"

-- f, F, t, T can search across lines, with n, N for next and prev
vim.keymap.set('n', 'f', function()
		local count = 1
		if vim.v.count ~= 0 then
				count = vim.v.count	
		end
		local char_code = vim.fn.getchar()
		local char = vim.fn.nr2char(char_code)
		local search_char = vim.fn.escape(char, '"\\')
		-- Set the search register directly
		vim.cmd('let @/ = "' .. search_char .. '"')
		-- Then, execute a normal mode command to find the next occurrence
		-- 'n' is "next" search result
		for i = 1, count do
				vim.cmd('normal! n')
		end
		vim.cmd(':noh')
end, { noremap = true, silent = true, desc = "Search forward for character and jump" })
vim.keymap.set('n', 'F', function()
		local count = 1
		if vim.v.count ~= 0 then
				count = vim.v.count	
		end
		local char_code = vim.fn.getchar()
		local char = vim.fn.nr2char(char_code)
		local search_char = vim.fn.escape(char, '"\\')
		-- Set the search register directly
		vim.cmd('let @/ = "' .. search_char .. '"')
		-- Then, execute a normal mode command to find the next occurrence
		-- 'n' is "next" search result
		for i = 1, count do
				vim.cmd('normal! N')
		end
		vim.cmd(':noh')
end, { noremap = true, silent = true, desc = "Search forward for character and jump" })
vim.keymap.set('n', 't', function()
		local count = 1
		if vim.v.count ~= 0 then
				count = vim.v.count	
		end
		local char_code = vim.fn.getchar()
		local char = vim.fn.nr2char(char_code)
		local search_char = vim.fn.escape(char, '"\\`')
		-- Set the search register directly
		vim.cmd('let @/ = "' .. search_char .. '"')
		-- Then, execute a normal mode command to find the next occurrence
		-- 'n' is "next" search result
		for i = 1, count do
				vim.cmd('normal! n')
		end
		vim.cmd('normal! h')
		vim.cmd(':noh')
end, { noremap = true, silent = true, desc = "Search forward for character and jump" })
vim.keymap.set('n', 'T', function()
		local count = 1
		if vim.v.count ~= 0 then
				count = vim.v.count	
		end
		local char_code = vim.fn.getchar()
		local char = vim.fn.nr2char(char_code)
		local search_char = vim.fn.escape(char, '"\\')
		-- Set the search register directly
		vim.cmd('let @/ = "' .. search_char .. '"')
		-- Then, execute a normal mode command to find the next occurrence
		-- 'n' is "next" search result
		for i = 1, count do
				vim.cmd('normal! N')
		end
		vim.cmd('normal! l')
		vim.cmd(':noh')
end, { noremap = true, silent = true, desc = "Search forward for character and jump" })


vim.keymap.set('n', '<leader>c', ':noh<CR>')
vim.keymap.set('n',  '<leader>q', ':wqa<CR>')
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('n', '<leader>-', ':split<CR>')
vim.keymap.set('n', '<leader>|', ':vsplit<CR>')
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

-- Easier window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Instead of dealing with true lines (\n), deal with lines displayed on screen (wraparound)
-- vim.keymap.set('n', 'j', 'gj--')
-- vim.keymap.set('n', 'k', 'gk')
-- vim.keymap.set('n', '^', 'g^')
-- vim.keymap.set('n', '$', 'g$')
-- vim.keymap.set('n', 'j', 'gj')
-- vim.keymap.set('n', 'k', 'gk')
-- vim.keymap.set('n', '^', 'g^')
-- vim.keymap.set('n', '$', 'g$')

-- Always uses the clipboard when yanking (disabled)
-- vim.opt.clipboard = "unnamedplus"

-- Sets vim to use * registers for copying/pasting, uses winyank as clipboard provider
vim.g.clipboard = {
  name = "win32yank-wsl",
  copy = {
    ["*"] = { "win32yank.exe", "-i", "--crlf" },
    ["+"] = { "win32yank.exe", "-i", "--crlf" },
  },
  paste = {
    ["*"] = { "win32yank.exe", "-o", "--lf" },
    ["+"] = { "win32yank.exe", "-o", "--lf" },
  },
  cache_enabled = 0,
}

-- require("config.lazy")


-- Colorthemes
vim.pack.add({
		{ src = "https://github.com/projekt0n/github-nvim-theme" },
		{ src = "https://github.com/catppuccin/nvim" },
})
-- vim.cmd('colorscheme github_dark')
vim.cmd('colorscheme catppuccin-frappe')

-- LSP
vim.pack.add({
		"https://github.com/nvim-treesitter/nvim-treesitter",
		"https://github.com/neovim/nvim-lspconfig",
		"https://github.com/Saghen/blink.cmp",
})
require "nvim-treesitter.configs".setup({
		ensure_installed = { "go", "python" },
		highlight = { enable = true }
})
blink = require("blink.cmp")
blink.setup({
  -- Keymap configuration for blink.cmp
  -- 'default' (recommended): Mappings similar to built-in completions (C-y to accept)
  keymap = { preset = 'enter' },
  appearance = {
    nerd_font_variant = 'mono',
  },
  -- Shows function signatures
  signature = {
		  enabled = true,
		  window = { show_documentation = true },
  },
  completion = {
    -- documentation.auto_show = false: Only show the documentation popup when manually triggered (C-space)
    documentation = { auto_show = true },
  },
  -- Sources for completion suggestions
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  -- Uses the Rust fuzzy matcher if available, otherwise falls back to Lua with a warning.
  fuzzy = { implementation = "prefer_rust_with_warning" },
})
local lspconfig = require("lspconfig")
local capabilities = blink.get_lsp_capabilities()
-- Not neccesary for completion, just informs LSP of additional capabilities provided by Blink
lspconfig.gopls.setup({
		capabilities = capabilities
})
vim.lsp.enable({ "gopls", "pylsp" })
-- Show error messages
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', {})
vim.keymap.set('n', '<leader>s', vim.lsp.buf.signature_help, { silent = true })

-- Other packages
vim.pack.add({
		{ 
				src = "https://github.com/nvim-neo-tree/neo-tree.nvim",
				version = vim.version.range('3'),
		},
		"https://github.com/nvim-lua/plenary.nvim",
		"https://github.com/nvim-telescope/telescope.nvim",
		"https://github.com/MunifTanjim/nui.nvim",
		"https://github.com/windwp/nvim-autopairs",
		"https://github.com/stevearc/oil.nvim",
		"https://github.com/karb94/neoscroll.nvim"
})
require('nvim-autopairs').setup {}
require('oil').setup()
require('neoscroll').setup()

-- Plugin keybinds
telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader><leader>', telescope.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>b', telescope.buffers, { desc = 'Telescope find files' })
vim.keymap.set('n', '-', '<CMD>Oil<CR>')
