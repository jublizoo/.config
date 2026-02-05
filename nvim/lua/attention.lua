LockedIn = false;

local cmd = "mpv -vo tct"
local vids_dir = "~/Downloads/"
local vids = { "family", "fruit", "parkour", "subway", "family", "fruit", "parkour", "subway", "family" }
local ext = ".mp4"

local lock_in = function ()
	vim.cmd('only')

	-- local buf = vim.api.nvim_win_get_buf(0)
	vim.cmd("vsplit")
	vim.cmd("vsplit")
	vim.cmd("wincmd h")
	vim.cmd("split")
	vim.cmd("split")
	vim.cmd("wincmd l")
	vim.cmd("split")
	vim.cmd("split")
	vim.cmd("wincmd l")
	vim.cmd("split")
	vim.cmd("split")

	-- goto and get center window
	vim.cmd("wincmd h")
	vim.cmd("wincmd j")
	local center = vim.api.nvim_tabpage_get_win(0)

	-- get all windows in tab
  local wins = vim.api.nvim_tabpage_list_wins(0)

  local i = 1
  for _, w in ipairs(wins) do
    if w ~= center then
      vim.api.nvim_set_current_win(w)
      vim.cmd("term " .. cmd .. " " .. vids_dir .. vids[i] .. ext)
      i = i + 1
    end
  end

  vim.api.nvim_set_current_win(center)
end

local lock_out = function ()
	vim.cmd('only')
end

local attention = function  ()
	if LockedIn then
		lock_out()
	else
		lock_in()
	end
	LockedIn = not LockedIn
end

vim.keymap.set('n', '<leader>a', attention)
