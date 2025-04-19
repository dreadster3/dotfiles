return {
	{ "Hoffs/omnisharp-extended-lsp.nvim", lazy = true },
	{
		"lspconfig",
		optional = true,
		opts = {
			servers = {
				omnisharp = {
					handlers = {
						["textDocument/definition"] = function(...)
							local utils = require("dreadster.utils")
							if utils.check_module_installed("omnisharp_extended") then
								require("omnisharp_extended").handler(...)
							end
						end,
					},
					enable_editorconfig_support = true,
					enable_ms_build_load_projects_on_demand = false,
					enable_roslyn_analyzers = false,
					organize_imports_on_format = true,
					enable_import_completion = true,
					sdk_include_prereleases = true,
					analyze_open_documents_only = false,
				},
			},
		},
	},
	{
		"conform",
		optional = true,
		opts = {
			formatters_by_ft = {
				cs = { "csharpier" },
			},
			formatters = {
				csharpier = {
					command = "dotnet-csharpier",
					args = { "--write-stdout" },
				},
			},
		},
	},
}
