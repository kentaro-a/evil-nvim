local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

--local keymap = vim.keymap
local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- Modes
--   normal_mode = 'n',
--   insert_mode = 'i',
--   visual_mode = 'v',
--   visual_block_mode = 'x',
--   term_mode = 't',
--   command_mode = 'c',
keymap("n", "j", "<Plug>(accelerated_jk_gj)", opts)
keymap("n", "k", "<Plug>(accelerated_jk_gk)", opts)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
-- keymap("n", "<C-j>", "<C-w>j", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "gg", 'gg0', opts)
keymap("n", "ga", 'gg0v<S-g>$<Left>', opts)
keymap("n", "<CR>", '$a<CR><Esc>', opts)
keymap("n", "x", '"_x', opts)
keymap("n", "s", '"_s', opts)
keymap("x", "p", '"_dP', opts)
keymap("n", "<S-h>", "^", opts)
keymap("n", "<S-l>", "$", opts)
keymap("n", "<Esc><Esc>", ":nohl<cr>", opts)
keymap("i", "jj", "<ESC>", opts)
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "<S-h>", "^", opts)
keymap("v", "<S-l>", "$<Left>", opts)
keymap("n", "<S-t>", ":tabedit<CR>", opts)
keymap("n", "gn", ":tabnew<Return>", opts)
keymap("n", "--", "gcc", opts)
keymap("v", "--", "gc", opts)
keymap('n', '<F2>', ':set invpaste paste?<CR>',  opts)
vim.opt.pastetoggle = '<F2>'

keymap("n", "<S-Left>", "gT", opts)
keymap("n", "<S-Right>", "gt", opts)

-- nnoremap <silent> <Space><Space> ""yiw:let @/ = '\<' . @" . '\>'<CR>:set hlsearch<CR>
-- vnoremap <silent> <Space><Space> ""y:let @/ = @"<CR>:set hlsearch<CR>



keymap("n", "<Space>f", "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
keymap("n", "<Space>g", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
keymap("n", "<Space>,", "<cmd>lua require('telescope.builtin').grep_string()<cr>", opts)
keymap('n', '<Space><Space>', "yiw<cmd>lua require('lasterisk').search()require('hlslens').start()<cr>", opts)
keymap('x', '<Space><Space>', "<cmd>lua require('lasterisk').search({ is_whole = false })require('hlslens').start()<cr>", opts)
keymap('n', '<Space>r', ':%s///g<left><left>', {noremap = true})

keymap('n', '<C-j>', '<Plug>(edgemotion-j)', {noremap = true})
keymap('n', '<C-k>', '<Plug>(edgemotion-k)', {noremap = true})

keymap('n', 'm', "<cmd>lua require'hop'.hint_words()<cr>", {noremap = true})

