-- LSP configuration/settings
vim.opt.signcolumn = 'yes' -- reserving space for diagnostic icons

local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.ensure_installed({
	'clangd',
	'pyright'
})

lsp.on_attach(function(client, bufnr)
	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end,     { desc = '[G]o to [d]efinition',buffer = bufnr, remap = false }))
	vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end,    { desc = '[G]o to [D]eclaration',buffer = bufnr, remap = false }))
	vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end,     { desc = '[G]o to [R]eferences (with LSP)', buffer = bufnr, remap = false })
	vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, { desc = '[G]o to [I]mplementation (with LSP)', buffer = bufnr, remap = false })
	vim.keymap.set("n", "K",  function() vim.lsp.buf.hover() end,          { desc = '[K] Hover info', buffer = bufnr, remap = false })
	vim.keymap.set("n", "R",  function() vim.lsp.buf.rename() end,         { desc = '[R]ename symbol (with LSP)', buffer = bufnr, remap = false })
end)

-- Set up lspconfig
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- specific lsp server configurations
require('lspconfig')['clangd'].setup { capabilities = capabilities }
require('lspconfig')['pyright'].setup { capabilities = capabilities }

-- finally setup the lsp client
lsp.setup()
