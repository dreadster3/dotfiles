return {
	{
		"rainbow-delimiters",
		optional = true,
		opts = {
			blacklist = { "markdown" },
		},
	},
	{
		"lspconfig",
		optional = true,
		opts = {
			servers = {
				marksman = {
					mason = false,
				},
			},
		},
	},
	{
		"conform",
		optional = true,
		opts = {
			formatters_by_ft = {
				markdown = { "prettier", "markdownlint-cli2" },
			},
		},
	},
	{
		"nvim-lint",
		optional = true,
		opts = {
			linters_by_ft = {
				markdown = { "markdownlint-cli2" },
			},
		},
	},
	{
		"iamcco/markdown-preview.nvim",
		name = "markdown-preview",
		version = "*",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview" },
		build = "cd app && npx --yes yarn install",
		ft = { "markdown" },
		keys = {
			{
				"<leader>md",
				"<CMD>MarkdownPreviewToggle<CR>",
				desc = "Toggle markdown preview",
			},
		},
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		name = "render-markdown",
		dependencies = { "treesitter", "echasnovski/mini.icons" }, -- if you use standalone mini plugins
		ft = { "markdown" },
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			file_types = { "markdown" },
		},
	},
}
