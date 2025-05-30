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
			{ import = "dreadster.plugins.ai" }, -- AI support
		},
		defaults = { lazy = true },
		-- install = {colorscheme = {"catppuccin-mocha"}},
		checker = { enabled = true },
		performance = {
			cache = { enabled = true },
			rtp = {
				disabled_plugins = {
					"2html_plugin",
					"tohtml",
					"getscript",
					"getscriptPlugin",
					"gzip",
					"logipat",
					"netrw",
					"netrwPlugin",
					"netrwSettings",
					"netrwFileHandlers",
					"matchit",
					"tar",
					"tarPlugin",
					"rrhelper",
					"spellfile_plugin",
					"vimball",
					"vimballPlugin",
					"zip",
					"zipPlugin",
					"tutor",
					"rplugin",
					"syntax",
					"synmenu",
					"optwin",
					"compiler",
					"bugreport",
					"ftplugin",
				},
			},
		},
		dev = { path = "~/Documents/projects/github" },
		debug = false,
	}, opts or {})
	require("lazy").setup(opts)
end
