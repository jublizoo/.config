-- f, F, t, T can search across lines, with n, N for next and prev
local function search (key, reverse, stop_short)
	vim.keymap.set('n', key, function()
		local count = vim.v.count ~= 0 and vim.v.count or 1
		local char = vim.fn.nr2char(vim.fn.getchar())
		-- Escape regex magic characters
		local search_char = vim.fn.escape(char, [[.^$*]])
		-- Set search register
		vim.fn.setreg('/', search_char)
		local next_key = reverse and 'N' or 'n'
		-- Move to match
		for _ = 1, count do
			vim.cmd('normal! ' .. next_key)
		end
		vim.cmd('noh')

		if stop_short then
			local move_key = reverse and 'l' or 'h'
			vim.cmd('normal! ' .. move_key)
		end

	end, { noremap = true, silent = true, desc = "custom f/t search" })
end
search('f', false, false)
search('F', true, false)
search('t', false, true)
search('T', true, true)


-- local blink = require("blink.cmp")
-- blink.setup({
--   -- Keymap configuration for blink.cmp
--   -- 'default' (recommended): Mappings similar to built-in completions (C-y to accept)
--   keymap = { preset = 'enter' },
--   appearance = {
--     nerd_font_variant = 'mono',
--   },
--   -- Shows function signatures
--   signature = {
-- 		  enabled = true,
-- 		  window = { show_documentation = true },
--   },
--   completion = {
--     -- documentation.auto_show = false: Only show the documentation popup when manually triggered (C-space)
--     documentation = { auto_show = true },
--   },
--   -- Sources for completion suggestions
--   sources = {
--     default = { 'lsp', 'path', 'snippets', 'buffer' },
--   },
--   -- Uses the Rust fuzzy matcher if available, otherwise falls back to Lua with a warning.
--   fuzzy = { implementation = "lua" },
-- })
-- Not neccesary for completion, just informs LSP of additional capabilities provided by Blink
-- local capabilities = blink.get_lsp_capabilities()
-- lspconfig.gopls.setup({
-- 		capabilities = capabilities
-- })

