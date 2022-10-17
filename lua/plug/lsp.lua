local status_ok, lsp = pcall(require, "lspconfig")
if not status_ok then 
	return 
end

vim.diagnostic.config({ virtual_text = true })

local diagnostic_signs = {
	{ name = "DiagnosticSignError", text = "" },
	{ name = "DiagnosticSignWarn",  text = "" },
	{ name = "DiagnosticSignHint",  text = "" },
	{ name = "DiagnosticSignInfo",  text = "" },
}

for _, sign in ipairs(diagnostic_signs) do
	vim.fn.sign_define(sign.name, {
		texthl = sign.name,
		text   = sign.text,
		numhl  = sign.name,
	})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.offsetEncoding = { "utf-16" }

lsp.eslint.setup{}
lsp.emmet_ls.setup{}
lsp.html.setup{}
lsp.tsserver.setup{}
lsp.jsonls.setup{}
lsp.pyright.setup{}
lsp.jdtls.setup{}
lsp.bashls.setup{}
lsp.sqls.setup{}
lsp.sumneko_lua.setup{}
lsp.tailwindcss.setup{}
lsp.clangd.setup({ capabilities = capabilities })