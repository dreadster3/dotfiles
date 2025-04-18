local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

return function(opts)
	opts = vim.tbl_deep_extend("force", {
		spec = {
			-- {"LazyVim/LazyVim", import = "lazyvim.plugins", opts = {}},
			{ import = "dreadster.plugins" },
			{ import = "dreadster.plugins.lang" }, -- Programming languages support
		},
		defaults = { lazy = false },
		-- install = {colorscheme = {"catppuccin-mocha"}},
		checker = { enabled = true },
		performance = {
			cache = { enabled = true },
			rtp = {
				disabled_plugins = {
					"gzip",
					"netrwPlugin",
					"rplugin",
					"tarPlugin",
					"tohtml",
					"tutor",
					"zipPlugin",
					"tarPlugin",
				},
			},
		},
		dev = { path = "~/Documents/projects/github" },
		debug = false,
	}, opts or {})
	require("lazy").setup(opts)
end
