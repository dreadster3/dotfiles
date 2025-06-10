return {
	{
		"lspconfig",
		optional = true,
		opts = {
			servers = {
				neocmake = {},
				qmlls = {
					cmd = { "qmlls", "-E" },
				},
				clangd = {
					cmd = {
						"clangd",
						"--background-index",
						"--clang-tidy",
						"--header-insertion=iwyu",
						"--completion-style=detailed",
						"--function-arg-placeholders",
						"--fallback-style=llvm",
					},
					filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
				},
			},
		},
	},
	{
		"nvim-lint",
		optional = true,
		opts = {
			linters_by_ft = {
				cmake = { "cmakelint" },
			},
		},
	},
	{
		"conform",
		optional = true,
		opts = {
			formatters_by_ft = {
				qml = { "qmlformat" },
				cmake = { "cmake_format" },
				cpp = { "clang-format" },
			},
		},
	},
	{
		"Civitasv/cmake-tools.nvim",
		lazy = true,
		ft = { "cmake", "cpp" },
		dependencies = { "nvim-lua/plenary.nvim", "telescope.nvim" },
		-- init = function()
		-- 	local loaded = false
		-- 	local function check()
		-- 		local cwd = vim.uv.cwd()
		-- 		if vim.fn.filereadable(cwd .. "/CMakeLists.txt") == 1 then
		-- 			require("lazy").load({ plugins = { "cmake-tools.nvim" } })
		-- 			loaded = true
		-- 		end
		-- 	end
		-- 	check()
		-- 	vim.api.nvim_create_autocmd("DirChanged", {
		-- 		callback = function()
		-- 			if not loaded then
		-- 				check()
		-- 			end
		-- 		end,
		-- 	})
		-- end,
		opts = {
			cmake_runner = {
				name = "toggleterm",
			},
			cmake_notifications = {
				runner = { enabled = false },
			},
		},
	},
}
