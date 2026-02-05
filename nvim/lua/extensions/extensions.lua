require('oil').setup({
	view_options = {
		show_hidden = false,
		is_hidden_file = function(name, bufnr) 
			if name:match("^%.") then 
				return true
			end

			local hidden_exts = {
				[".o"] = true,
				[".a"] = true,
				[".dep"] = true,
			}

			for ext, _ in pairs(hidden_exts) do 
				if name:sub(-#ext) == ext then
					return true
				end
			end

			return false
		end,
	},
})
vim.keymap.set('n', '-', '<CMD>Oil<CR>')

local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', telescope.live_grep, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fb', telescope.buffers, { desc = 'Telescope find files' })

require('arrow').setup({
	show_icons = false,
    leader_key = ';',
    buffer_leader_key = 'm',
})

require('neoscroll').setup()
require('nvim-autopairs').setup {}

require('extensions.obsidian')
