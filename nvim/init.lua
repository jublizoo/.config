-- TODO: Comment in normal mode
-- Enter (O + esc)
-- Tip: use CC for indent on empty line
--
-- gcc in normal mode to comment, gc in visual 

vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
-- - SELECT x FROM my_table WHERE name = "chung" GROUPBY column_name
--aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa

-- Width of actual tab character, in columns. Alignment to this number of columns.

vim.o.tabstop = 4
-- Whitespace used for an indentation. Multiple indentations at the start is affected by this.
vim.o.shiftwidth = 4
vim.o.expandtab = false
vim.o.swapfile = false
vim.o.signcolumn = "yes"
vim.g.mapleader = " "
vim.g.maplocalleader = "  "
vim.o.linebreak = true

local function scroll_quarter(dir)
	local win = 0
	local v = vim.fn.winsaveview()
	local h = vim.api.nvim_win_get_height(win)
	local n = math.max(1, math.floor(h / 6))

	v.topline = math.max(1, v.topline + (dir * n))
	v.lnum    = math.max(1, v.lnum    + dir * n)
	vim.fn.winrestview(v)
end

vim.keymap.set("n", "<C-e>", function() scroll_quarter( 1) end, { silent = true })
vim.keymap.set("n", "<C-y>", function() scroll_quarter(-1) end, { silent = true })


-- Change cursor 
vim.opt.guicursor = "n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor"

vim.keymap.set('i', 'jj', '<Esc>')
-- Don't want enter to add Comments
-- vim.keymap.set('n', '<CR>', 'o<Esc>cc<Esc>')
vim.keymap.set('n', '<leader>c', 'cc<Esc>')
vim.keymap.set('n',  '<leader>q', ':wqa<CR>')
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>-', ':split<CR>')
vim.keymap.set('n', '<leader>|', ':vsplit<CR>')
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

-- Easier window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Colorthemes
vim.pack.add({
	{ src = "https://github.com/projekt0n/github-nvim-theme" },
	{ src = "https://github.com/catppuccin/nvim" },
})
vim.cmd('colorscheme catppuccin-frappe')

require("extensions.pack")
require("lsp.setup");
-- Must be after lsp.setup, obsidian uses nvim-cmp
require("extensions.extensions")
require("attention")
package.loaded["gradient"] = nil
local grad = require("gradient")
grad.ApplyGradient()
