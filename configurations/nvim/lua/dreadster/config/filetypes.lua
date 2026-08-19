vim.filetype.add({
	filename = {
		["docker-compose.yaml"] = "yaml.docker-compose",
		["docker-compose.yml"] = "yaml.docker-compose",
		["compose.yaml"] = "yaml.docker-compose",
		["compose.yml"] = "yaml.docker-compose",
	},
	pattern = {
		[".*/%.github/workflows/.*%.yml"] = "yaml.ghaction",
		[".*/%.github/workflows/.*%.yaml"] = "yaml.ghaction",
		-- template files (foo.yaml.j2 / foo.yaml.tmpl) inherit the previous extension's filetype, with the template ext as suffix (yaml.j2)
		[".*%..*%.j2"] = function(path, _buf)
			return vim.fn.fnamemodify(path, ":r:e") .. ".j2"
		end,
		[".*%..*%.tmpl"] = function(path, _buf)
			return vim.fn.fnamemodify(path, ":r:e") .. ".tmpl"
		end,
	},
	extension = {
		wiz = "yaml",
	},
})
