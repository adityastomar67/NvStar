local status_ok, lsp = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("plug.lsp.lsp-installer")
-- require("plug.lsp.lsp-saga") -- Special symbols for moere info about buffer in winbar...MUST TRY!!
require("plug.lsp.null-ls")

vim.diagnostic.config({ virtual_text = true })

local diagnostic_signs = {
	{ name = "DiagnosticSignError", text = "" },
	{ name = "DiagnosticSignWarn" , text = "" },
	{ name = "DiagnosticSignHint" , text = "" },
	{ name = "DiagnosticSignInfo" , text = "" },
}

for _, sign in ipairs(diagnostic_signs) do
	vim.fn.sign_define(sign.name, {
		texthl = sign.name,
		text   = sign.text,
		numhl  = sign.name,
	})
end

lsp.html.setup({})
-- lsp.jdtls.setup({})
-- lsp.bashls.setup({})
lsp.eslint.setup({})
lsp.pyright.setup({})
lsp.tsserver.setup({})
lsp.tailwindcss.setup({})
lsp.sqls.setup(require("plug.lsp.servers.sqls"))
lsp.jsonls.setup(require("plug.lsp.servers.jsonls"))
lsp.clangd.setup(require("plug.lsp.servers.clangd"))
lsp.emmet_ls.setup(require("plug.lsp.servers.emmet-ls"))
lsp.sumneko_lua.setup(require("plug.lsp.servers.sumneko-lua"))
