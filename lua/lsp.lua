
vim.keymap.set('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', ',f', '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', ',d', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', ',D', '<cmd>lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n', ',r', '<cmd>lua vim.lsp.buf.rename()<CR>')

-- LSP handlers
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)
-- Reference highlight
vim.cmd [[
set updatetime=500
highlight LspReferenceText  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
highlight LspReferenceRead  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
highlight LspReferenceWrite cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
augroup lsp_document_highlight
autocmd!
autocmd CursorHold,CursorHoldI * lua vim.lsp.buf.document_highlight()
autocmd CursorMoved,CursorMovedI * lua vim.lsp.buf.clear_references()
augroup END
]]

-- 3. completion (hrsh7th/nvim-cmp)
local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	sources = {
		{ name = "nvim_lsp" },
		-- { name = "buffer" },
		-- { name = "path" },
	},
	mapping = cmp.mapping.preset.insert({
		["<CR>"] = cmp.mapping.confirm { select = true },
		['<Tab>'] = cmp.mapping(function(fallback)
			local col = vim.fn.col('.') - 1

			if cmp.visible() then
				cmp.select_next_item(select_opts)
			elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
				fallback()
			else
				cmp.complete()
			end
		end, {'i', 's'}),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item(select_opts)
			else
				fallback()
			end
		end, {'i', 's'}),
	}),
	experimental = {
		ghost_text = true,
	},
})
-- cmp.setup.cmdline('/', {
	--   mapping = cmp.mapping.preset.cmdline(),
	--   sources = {
		--     { name = 'buffer' }
		--   }
		-- })
		-- cmp.setup.cmdline(":", {
			--   mapping = cmp.mapping.preset.cmdline(),
			--   sources = {
				--     { name = "path" },
				--     { name = "cmdline" },
				--   },
				-- })
