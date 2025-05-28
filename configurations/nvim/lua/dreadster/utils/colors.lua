-- The MIT License (MIT)
--
-- Copyright (c) 2022 Leon Heidelbach
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

-- All credits to https://github.com/LeonHeidelbach for making this!
-- 90% of functions are written by him

local M = {}

-- Convert a hex color value to RGB
-- @param hex: The hex color value
-- @return r: Red (0-255)
-- @return g: Green (0-255)
-- @return b: Blue (0-255)
M.hex2rgb = function(hex)
	local hash = string.sub(hex, 1, 1) == "#"
	if string.len(hex) ~= (7 - (hash and 0 or 1)) then
		return nil
	end

	local r = tonumber(hex:sub(2 - (hash and 0 or 1), 3 - (hash and 0 or 1)), 16)
	local g = tonumber(hex:sub(4 - (hash and 0 or 1), 5 - (hash and 0 or 1)), 16)
	local b = tonumber(hex:sub(6 - (hash and 0 or 1), 7 - (hash and 0 or 1)), 16)
	return r, g, b
end

-- Convert an RGB color value to hex
-- @param r: Red (0-255)
-- @param g: Green (0-255)
-- @param b: Blue (0-255)
-- @return The hexadecimal string representation of the color
M.rgb2hex = function(r, g, b)
	return string.format("#%02x%02x%02x", math.floor(r), math.floor(g), math.floor(b))
end

-- Mix two colors with a given percentage.
-- @param first The primary hex color.
-- @param second The hex color you want to mix into the first color.
-- @param strength The percentage of second color in the output.
--                 This needs to be a number between 0 - 100.
-- @return The mixed color as a hex value
M.mix = function(first, second, strength)
	if strength == nil then
		strength = 0.5
	end

	local s = strength / 100
	local r1, g1, b1 = M.hex2rgb(first)
	local r2, g2, b2 = M.hex2rgb(second)

	if r1 == nil or r2 == nil then
		return first
	end

	if s == 0 then
		return first
	elseif s == 1 then
		return second
	end

	local r3 = r1 * (1 - s) + r2 * s
	local g3 = g1 * (1 - s) + g2 * s
	local b3 = b1 * (1 - s) + b2 * s

	return M.rgb2hex(r3, g3, b3)
end

local hlcache = {}
local icon = "󱓻"
local palette = require("catppuccin.palettes").get_palette()
M.lsp = function(entry, item, kind_txt)
	local color = entry.completion_item.documentation

	if color and type(color) == "string" and color:match("^#%x%x%x%x%x%x$") then
		local hl = "hex-" .. color:sub(2)

		if not hlcache[hl] then
			vim.api.nvim_set_hl(0, hl, { fg = color, bg = M.mix(color, palette.base, 70) })
			hlcache[hl] = true
		end

		item.kind = icon .. " " .. kind_txt
		item.kind_hl_group = hl
	end
end

return M
