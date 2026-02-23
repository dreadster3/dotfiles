return {
	{
		"lspconfig",
		optional = true,
		opts = function(_, opts)
			return vim.tbl_deep_extend("force", opts or {}, {
				servers = {
					jsonls = {
						filetypes = { "json", "jsonc", "json5" },
						-- lazy-load schemastore when needed
						before_init = function(_, new_config)
							new_config.settings.json.schemas = new_config.settings.json.schemas or {}
							vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
						end,
						settings = {
							json = {
								format = {
									enable = true,
								},
								validate = {
									enable = true,
								},
							},
						},
					},
				},
			})
		end,
	},
	{
		"b0o/SchemaStore.nvim",
		lazy = true,
		version = false, -- last release is way too old
	},
	{
		"conform",
		optional = true,
		opts = {
			formatters_by_ft = {
				json = { "prettier" },
				jsonc = { "prettier" },
				json5 = { "prettier" },
			},
		},
	},
}
