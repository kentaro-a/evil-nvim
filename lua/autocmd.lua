



-- NvimTree -> tab本体にフォーカスする
vim.api.nvim_create_autocmd("TabEnter", {
	command = ":wincmd l",
})
-- tabを閉じた時に併設されたNvimTreeも一緒に閉じる
vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("NvimTreeClose", {clear = true}),
	pattern = "NvimTree_*",
	callback = function()
		local layout = vim.api.nvim_call_function("winlayout", {})
		if layout[1] == "leaf" and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree" and layout[3] == nil then vim.cmd("confirm quit") end
	end
})

-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	callback = function()
-- 		vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
-- 	end
-- })
--

