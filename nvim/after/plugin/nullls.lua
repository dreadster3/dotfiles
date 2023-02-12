local function addIfExecutable(list, command, value) 
    if vim.fn.executable(command) == 1 then
        table.insert(list, value)
    else
        vim.notify(command .. " not found.", "WARN", {
            title = "null-ls"
        })
    end
end

local function hasValue(list, value)
	for _, v in ipairs(list) do
		if v == value then
			return true
		end
	end

	return false
end

local null_ls = require('null-ls')

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local disabled = {"tsserver"}

local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        timeout_ms = 2000,
        filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            return not hasValue(disabled, client.name)
        end,
        bufnr = bufnr,
    })
end

local sources = {
    formatting.clang_format
}

addIfExecutable(sources, "prettier", formatting.prettier)
addIfExecutable(sources, "csharpier", formatting.csharpier)
addIfExecutable(sources, "terraform", formatting.terraform_fmt)
addIfExecutable(sources, "eslint", diagnostics.eslint)

null_ls.setup({
	sources = sources,
	on_attach = function(client, bufnr)
        print(client)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
					lsp_formatting(bufnr)
                end,
            })
        end
    end,
})
