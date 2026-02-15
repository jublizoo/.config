vim.pack.add({
	"https://github.com/L3MON4D3/LuaSnip",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/Saghen/blink.cmp",
	"https://github.com/hrsh7th/nvim-cmp",
})

require "nvim-treesitter".install { "go", "python", "c", "rust", "cpp" }


-- More options availabe, such as git completion
local cmp = require "cmp"
cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	window = {
		completion = {
			max_height = 10, max_width = 15,
		},
		documentation = {
			max_height = 10, max_width = 15,
		},
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources(
		{ { name = 'nvim_lsp' }, { name = 'luasnip' } },
		{ { name = 'buffer' },
	})
})

vim.lsp.enable({ "gopls", "pylsp", "clangd", "lua-ls" })
-- Show error messages
vim.keymap.set('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', {})
vim.keymap.set('n', '<leader>s', vim.lsp.buf.signature_help, { silent = true })
vim.keymap.set('n', '<leader>t', vim.lsp.buf.hover)
vim.keymap.set('n', 'grr', vim.lsp.buf.references)
vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition)
vim.keymap.set('n', 'gD', vim.lsp.buf.definition)
vim.keymap.set('n', 'gd', function() print("hello") end)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
vim.keymap.set('n', 'gl', vim.lsp.buf.document_symbol)
vim.keymap.set('n', 'gd', function ()
	vim.lsp.buf.definition({
		on_list = function (on_list)
			-- Specified in get_locations function called by definition()
			---@type vim.quickfix.entry[]
			local items = on_list.items
			local loc = items[1]
			local w = vim.api.nvim_get_current_win()
			local b = loc.bufnr or vim.fn.bufadd(loc.filename)
			vim.api.nvim_win_set_buf(w, b)
			vim.api.nvim_win_set_cursor(w, { loc.lnum, loc.col - 1 })
			vim._with({ win = w }, function()
				-- Open folds under the cursor
				vim.cmd('normal! zv')
			end)
			if #items ~= 1 then
				print("multiple definitions found")
			end
		end
	})
end)

require("lsp.c")
require("lsp.go")
require("lsp.rust")
require("lsp.lean")
require("lsp.lua")
