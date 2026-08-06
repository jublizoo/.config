require("rustaceanvim")

vim.g.rustaceanvim = {
	server = {
		default_settings = {
			['rust-analyzer'] = {
				completion = {
					termSearch = { enable = false, },
				},
				-- For kernel, custom target breaks rust lsp
				cargo = {
					target = "x86_64-unknown-linux-gnu"
				},
			},
		},
	},
}

vim.keymap.set('n', 'ge', function() vim.cmd.RustLsp('expandMacro') end)

-- require('rust-tools').setup({
-- 	server = {
-- 		settings = {
-- 			["rust-analyzer"] = {
-- 				procMacro = {
-- 					enable = true
-- 				}
-- 			}
-- 		}
-- 	}
-- })
--
