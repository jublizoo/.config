require('obsidian').setup({
	workspaces = {
		{
			name = "personal",
			path = "~/",
		},
	},
	completion = {
		nvim_cmp = true,
		min_chars = 1,
	},
})

local function enter_md()
	-- obsidian.nvim, wrapped lines on bullets/other indentations should indent on wrap.
	vim.o.breakindent = true
	vim.o.wrap = true
	-- Instead of dealing with true lines (\n), deal with lines displayed on screen (wraparound)
	vim.keymap.set('n', '^', 'g^')
	vim.keymap.set('n', '$', 'g$')
	vim.keymap.set('n', 'j', 'gj')
	vim.keymap.set('n', 'k', 'gk')

	-- keys that should behave differently w.r.t. wrapped lines
	local wrap_keys = { '^', '$', 'j', 'k' }
	for _, key in ipairs(wrap_keys) do
		vim.keymap.set('n', key, function ()
			local count = vim.v.count1
			if count <= 1 then
				vim.cmd("normal! " .. count .. "g" .. key)
			else
				vim.cmd("normal!" .. count .. key)
			end
		end)
	end

	-- conceal by only showing 1 char
	-- vim.opt_local.conceallevel = 3
	-- modes where conceal is active
    -- vim.opt_local.concealcursor = "nc"
    -- vim.cmd([[
    --   syntax match UrlFull /https\?:\/\/\S\+/ conceal
    -- ]])
end

local function exit_md()
	vim.o.breakindent = false
	vim.o.wrap = false
	vim.keymap.del('n', 'j')
	vim.keymap.del('n', 'k')
	vim.keymap.del('n', '^')
	vim.keymap.del('n', '$')
end

local enter_exit_hooks = {{ ".md", enter_md, exit_md }}
local in_exts = {}
for i = 1, #enter_exit_hooks do
	in_exts[i] = false
end
vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' },  {
	callback = function(opts)
		local filename = tostring(opts.file)

		for i, hooks in ipairs(enter_exit_hooks) do
			local ext = hooks[1]
			local enter = hooks[2]
			local exit = hooks[3]
			if string.match(filename, ext .. "$") then
				if not in_exts[i] then
					enter()
				end
				in_exts[i] = true
			else
				if in_exts[i] then
					exit()
				end
				in_exts[i] = false
			end
		end
	end
})
