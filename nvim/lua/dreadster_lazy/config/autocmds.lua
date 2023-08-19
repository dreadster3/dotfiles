local au = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local opts = { noremap = true, buffer = 0 }
local nnoremap = function(lhs, rhs) vim.keymap.set('n', lhs, rhs, opts) end

local cpp_maps = {
	pattern = { "CMakeLists.txt", "conanfile.txt", "*.cpp", "*.hpp", "*.h" },
	keymaps = {
		{ "<leader>cb", ":Task start cmake build<CR>" },
		{ "<leader>cg", ":Task start cmake configure<CR>" },
		{ "<leader>ci", ":Task start conan install<CR>" }
	}
}

local terraform_maps = {
	pattern = { "*.tf" },
	keymaps = {
		{ "<leader>tfi", ":Task start terraform init<CR>" },
		{ "<leader>tfv", ":Task start terraform validate<CR>" }
	}
}

local maps = { cpp_maps, terraform_maps }

local tasks_group = augroup("tasks", { clear = true })
for _, map in ipairs(maps) do
	au("BufEnter", {
		group = tasks_group,
		pattern = map.pattern,
		callback = function()
			for _, keymap in ipairs(map.keymaps) do
				nnoremap(keymap[1], keymap[2])
			end
		end
	})
end


vim.api.nvim_create_autocmd("BufReadPre", {
	group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
	pattern = "Cargo.toml",
	callback = function()
		local cmp = require("cmp")
		cmp.setup.buffer({ sources = { { name = "crates" } } })

		local opts = { noremap = true, silent = true }
		local keymap = vim.api.nvim_buf_set_keymap
		keymap(0, 'n', '<F4>', "<cmd>lua require('crates').show_popup()<CR>",
			opts)
		keymap(0, 'n', 'cf',
			"<cmd>lua require('crates').show_features_popup()<CR>", opts)
		keymap(0, 'n', 'cr', "<cmd>lua require('crates').reload()<CR>", opts)
		keymap(0, 'n', 'cd', "<cmd>lua require('crates').open_crates_io()<CR>",
			opts)
		keymap(0, 'n', 'cu', "<cmd>lua require('crates').update_crate()<CR>",
			opts)
		keymap(0, 'n', 'cU',
			"<cmd>lua require('crates').update_all_crates()<CR>", opts)
	end
})
