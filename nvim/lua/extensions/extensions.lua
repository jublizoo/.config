require('oil').setup({
	view_options = {
		show_hidden = false,
		is_hidden_file = function(name, _)
			-- if name:match("^%.") then 
			-- 	return true
			-- end

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

require("winshift").setup()
vim.keymap.set('n', '<leader>m', ':WinShift<CR>')
local hjkl = { 'h', 'j', 'k', 'l' }
local dirs = { 'left', 'down', 'up', 'right' }
for i, key in ipairs(hjkl) do
	local dir = dirs[i]
	local combo = '<C-S-' .. key .. '>'
	local move_one = "WinShift " .. dir
	local move_n = function()
		for _ = 1, vim.v.count1 do
			-- Move twice to get more 'normal' behavior
			-- Moving once will join with the next window, creating a hsplit
			vim.cmd(move_one)
			vim.cmd(move_one)
		end
	end
	vim.keymap.set('n', combo, 	move_n)
end

-- require('arrow').setup({
-- 	show_icons = false,
--     leader_key = ';',
--     buffer_leader_key = 'm',
-- })

require('nvim-autopairs').setup {}

require('extensions.obsidian')
