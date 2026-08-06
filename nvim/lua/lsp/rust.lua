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
