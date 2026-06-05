require("rustaceanvim")

vim.g.rustaceanvim = {
	server = {
		default_settings = {
			['rust-analyzer'] = {
				completion = {
					termSearch = { enable = false, },
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
