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
					settings = {
						FormattingOptions = {
							-- Enables support for reading code style, naming convention and analyzer
							-- settings from .editorconfig.
							EnableEditorConfigSupport = true,
							-- Specifies whether 'using' directives should be grouped and sorted during
							-- document formatting.
							OrganizeImports = true,
						},
						MsBuild = {
							-- If true, MSBuild project system will only load projects for files that
							-- were opened in the editor. This setting is useful for big C# codebases
							-- and allows for faster initialization of code navigation features only
							-- for projects that are relevant to code that is being edited. With this
							-- setting enabled OmniSharp may load fewer projects and may thus display
							-- incomplete reference lists for symbols.
							LoadProjectsOnDemand = false,
						},
						RoslynExtensionsOptions = {
							-- Enables support for roslyn analyzers, code fixes and rulesets.
							EnableAnalyzersSupport = false,
							-- Enables support for showing unimported types and unimported extension
							-- methods in completion lists. When committed, the appropriate using
							-- directive will be added at the top of the current file. This option can
							-- have a negative impact on initial completion responsiveness,
							-- particularly for the first few completion sessions after opening a
							-- solution.
							EnableImportCompletion = true,
							-- Only run analyzers against open files when 'enableRoslynAnalyzers' is
							-- true
							AnalyzeOpenDocumentsOnly = false,
							-- Enables the possibility to see the code in external nuget dependencies
							EnableDecompilationSupport = true,
						},
						RenameOptions = {
							RenameInComments = nil,
							RenameOverloads = nil,
							RenameInStrings = nil,
						},
						Sdk = {
							-- Specifies whether to include preview versions of the .NET SDK when
							-- determining which version to use for project loading.
							IncludePrereleases = true,
						},
					},
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
