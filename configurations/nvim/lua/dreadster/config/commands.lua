vim.api.nvim_create_user_command("ProxyToggle", function()
	local current_http_proxy = vim.env.http_proxy or vim.env.HTTP_PROXY
	local current_https_proxy = vim.env.https_proxy or vim.env.HTTPS_PROXY

	if current_http_proxy == nil then
		vim.fn.setenv("HTTP_PROXY", vim.g.http_proxy)
		vim.fn.setenv("http_proxy", vim.g.http_proxy)
		vim.notify("HTTP proxy on")
	else
		vim.fn.setenv("HTTP_PROXY", "")
		vim.fn.setenv("http_proxy", "")
		vim.notify("HTTP proxy off")
	end

	if current_https_proxy == nil then
		vim.fn.setenv("HTTPS_PROXY", vim.g.https_proxy)
		vim.fn.setenv("https_proxy", vim.g.https_proxy)
		vim.notify("HTTPS proxy on")
	else
		vim.fn.setenv("HTTPS_PROXY", "")
		vim.fn.setenv("https_proxy", "")
		vim.notify("HTTPS proxy off")
	end
end, { nargs = 0 })
