local M = {}

local ns = vim.api.nvim_create_namespace("col_gradient")

-- small, fixed palette so you don't create thousands of hl-groups
local GRAD_LEN = 30
local BRIGHT_PERIOD = 8

local function clamp01(x)
	if x < 0 then return 0 end
	if x > 1 then return 1 end
	return x
end

local function rgb_hex(r, g, b)
  return string.format("#%02x%02x%02x", r, g, b)
end

local function hueToRgb(p, q, t)
	if t < 0 then t = t + 1 end
	if t > 1 then t = t - 1 end
	if t < 1/6 then return p + (q - p) * 6 * t end
	if t < 1/2 then return q end
	if t < 2/3 then return p + (q - p) * (2/3 - t) * 6; end
	return p;
end

function Round(n)
	return math.floor(n + 0.5)
end

local function hsl_to_rgb(h, s, l)
	local r, g, b, q, p
	if s == 0 then
		r, g, b = l, l, l
	else
		if l < 0.5 then q = l * (1 + s) else q = l + s - (l * s) end
		p = 2 * l - q
		r = hueToRgb(p, q, h + 1/3)
		g = hueToRgb(p, q, h)
		b = hueToRgb(p, q, h - 1/3)
	end

	return Round(r * 255), Round(g * 255), Round(b * 255)
end

-- define endpoints
local color_0_hsl = { 320, .77, .53 }
local color_1_hsl = { 288, 1.0, .57 }

local function wave(period, x, exp)
	local val = math.sin(x * 2 * math.pi / period)
	val = (val + 1) / 2
	val = val ^ exp
	return val
end

local function gradient_color(i)
	i = i + 13
	-- local t = clamp01(i / (GRAD_LEN - 1))
	local t = wave(GRAD_LEN * 2, i, 1)

	local h0, s0, l0 = color_0_hsl[1], color_0_hsl[2], color_0_hsl[3]
	local h1, s1, l1 = color_1_hsl[1], color_1_hsl[2], color_1_hsl[3]

	local d = (h0 - h1) % 360
	if d > 180 then d = d - 360 end
	local h = (h0 + d * t) % 360
	local s = s0 + (s1 - s0) * t
	local l = l0 + (l1 - l0) * t

	h = h / 360

	-- local brightness = wave(BRIGHT_PERIOD, i, 1.5) * 0.4
	-- l = l + (1 - l) * brightness

	local r, g, b = hsl_to_rgb(h, s, l)
	return r, g, b
end

I = 0
--- @return string
local function make_hl(i)
	local r, g, b = gradient_color(i)
	local name = ("grad_%03d"):format(I)
	vim.api.nvim_set_hl(0, name, { fg = rgb_hex(r, g, b) })
	I = I + 1
	return name
end

function M.ApplyGradient()
	local cur_buf_num = 0
	vim.api.nvim_buf_clear_namespace(cur_buf_num, ns, 0, -1)

	local lines = vim.api.nvim_buf_get_lines(cur_buf_num, 0, -1, false)
	local row_i = 10
	local line = lines[row_i]
	row_i = row_i - 1
	local n_chars = vim.fn.strchars(line)

	local parity = true
	for col = 0, n_chars - 1 do
		local char = vim.api.nvim_buf_get_text(cur_buf_num, row_i, col, row_i, col + 1, {})[1]
		if (char == " ") then
			if parity then parity = false
			else parity = true end
		end

		if not parity then
			local hl = 
			vim.api.nvim_buf_set_extmark(cur_buf_num, ns, row_i, col, {
				end_row = row_i,
				end_col = col + 1,
				hl_group = hl,
			})
			goto continue
		end

		local hl = make_hl(col)

		-- local step = Round(t * (STEPS - 1)) + 1
		-- local hl = hl_groups[step]

		-- local hls = vim.api.nvim_get_hl(ns, )
		-- local info = hls[hl]

		vim.api.nvim_buf_set_extmark(cur_buf_num, ns, row_i, col, {
			end_row = row_i,
			end_col = col + 1,
			hl_group = hl,
		})

		::continue::
	end
end

return M
