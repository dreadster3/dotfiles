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
	},
	extension = {
		wiz = "yaml",
	},
})
