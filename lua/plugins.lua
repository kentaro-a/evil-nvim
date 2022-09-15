local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})






-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here

	use({ "wbthomason/packer.nvim" })
	use({ "nvim-lua/plenary.nvim" }) -- Common utilities
	use({'tpope/vim-surround'})
	use({'tpope/vim-repeat'})
	use({"rhysd/accelerated-jk"})
	use({
		'terrortylor/nvim-comment', 
		config = function()
			require('nvim_comment').setup({
				create_mappings = true, 
				line_mapping = "--",
				operator_mapping = "-",
			})
		end,
	})
	use({
		'windwp/nvim-autopairs', 
		config = function() require("nvim-autopairs").setup {} end
	})	

	-- Colorschemes
	use({ 
		"EdenEast/nightfox.nvim", 
		conifg = function()

		end, 

	}) -- Color scheme

	use {
		'kyazdani42/nvim-tree.lua',
		requires = {
			'kyazdani42/nvim-web-devicons', -- optional, for file icons
		},
		tag = 'nightly', -- optional, updated every week. (see issue #1193)
		config = function()
			require("nvim-tree").setup({
				open_on_setup = true,
				open_on_setup_file = true,
				open_on_tab = true,
				sort_by = "case_sensitive",
				view = {
					width = 30,
					adaptive_size = false,
					mappings = {
						custom_only = true,
						list = {
							{ key = "R", action = "refresh" },
							{ key = "t", action = "tabnew" },
							{ key = "e", action = "edit" },
							{ key = "md", action = "remove" },
							{ key = "mm", action = "rename" },
							{ key = "ma", action = "create" },
							{ key = "mc", action = "copy" },
							{ key = "mp", action = "paste" },
							{ key = "<Tab>", action = "toggle_mark" },
							{ key = "|", action = "vsplit" },
							{ key = "-", action = "split" },
							{ key = "<S-Up>", action = "dir_up" },
							{ key = "cd", action = "cd" },
							{ key = {"<CR>", "o" }, action = "edit", mode = "n"},

						},
					},
				},
				renderer = {
					group_empty = true,
					highlight_opened_files = "none",
				},
				filters = {
					dotfiles = false,
				},
				git = {
					ignore = false,
				},
			})
		end,
	}


	use {
		'nvim-telescope/telescope.nvim',
		tag = '0.1.0',
		requires = { {'nvim-lua/plenary.nvim'} },
		config = function()
			require("telescope").setup({
				defaults = {
				},
				pickers = {
					find_files = {
					},	
					grep_string = {
					},
					live_grep = {
					},
				},
				extensions = {
				},
			})
		end,
	}



	use({
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true },
		config = function()
			require('lualine').setup({
				options = {
					icons_enabled = true,
					theme = 'auto',
					component_separators = { left = '', right = ''},
					section_separators = { left = '', right = ''},
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					globalstatus = false,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					}
				},
				sections = {
					lualine_a = {'mode'},
					lualine_b = {'branch', 'diff', 'diagnostics'},
					lualine_c = {'filename'},
					lualine_x = {'encoding', 'filetype'},
					lualine_y = {},
					lualine_z = {'location'}
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {'filename'},
					lualine_x = {'location'},
					lualine_y = {},
					lualine_z = {}
				},
				tabline = {
				},
				winbar = {},
				inactive_winbar = {},
				extensions = {"nvim-tree"}		
			})
		end,
	})


	use({
		'nvim-treesitter/nvim-treesitter',
		config = function()
			require('nvim-treesitter.configs').setup({
				highlight = {
					enable = true,
					disable = {},
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "gnn",
						node_incremental = "grn",
						node_decremental = "grm",
					},
				},
				ensure_installed = {
					'bash',
					'c',
					'clojure',
					'cpp',
					'css',
					'dockerfile',
					'go',
					'html',
					'javascript',
					'json',
					'jsonc',
					'lua',
					'make',
					'nix',
					'ocaml',
					'ocaml_interface',
					'prisma',
					'rust',
					'scheme',
					'toml',
					'typescript',
					'vue',
					'yaml',
				},		
			})
		end,
	})

	
	use({
		'rapan931/lasterisk.nvim',
		requires = {
			{
				'kevinhwang91/nvim-hlslens',
				config = function()
					require('hlslens').setup({
						override_lens = function(render, posList, nearest, idx, relIdx)
							local sfw = vim.v.searchforward == 1
							local indicator, text, chunks
							local absRelIdx = math.abs(relIdx)
							if absRelIdx > 1 then
								indicator = ('%d%s'):format(absRelIdx, sfw ~= (relIdx > 1) and '▲' or '▼')
							elseif absRelIdx == 1 then
								indicator = sfw ~= (relIdx == 1) and '▲' or '▼'
							else
								indicator = ''
							end

							local lnum, col = unpack(posList[idx])
							local cnt = #posList
							text = ('[%d/%d]'):format(idx, cnt)
							chunks = {{' ', 'Ignore'}, {text, 'HlSearchLens'}}
							render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
						end

					})
				end
				
			}
		},
	})


	use({'neovim/nvim-lspconfig'})
	use({
		'williamboman/mason.nvim',
		config = function()
			require('mason').setup()
		end,
	})
	use({
		'williamboman/mason-lspconfig.nvim',
		config = function()
			require('mason-lspconfig').setup_handlers({ function(server)
				local opt = {
					capabilities = require('cmp_nvim_lsp').update_capabilities(
						vim.lsp.protocol.make_client_capabilities()
					)
				}

				local node_root_dir = require('lspconfig').util.root_pattern("package.json")
				local is_node_repo = node_root_dir(vim.api.nvim_buf_get_name(0)) ~= nil

				if server_name == "tsserver" then
					if not is_node_repo then
						return
					end

					opt.root_dir = node_root_dir
				elseif server_name == "eslint" then
					if not is_node_repo then
						return
					end

					opt.root_dir = node_root_dir
				elseif server_name == "denols" then
					if is_node_repo then
						return
					end

					opt.root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc", "deps.ts", "import_map.json")
					opt.init_options = {
						lint = true,
						unstable = true,
						suggest = {
							imports = {
								hosts = {
									["https://deno.land"] = true,
									["https://cdn.nest.land"] = true,
									["https://crux.land"] = true
								}
							}
						}
					}
				end


				require('lspconfig')[server].setup(opt)
			end})
		end,
	})
	use({"hrsh7th/nvim-cmp"})
	use({"hrsh7th/cmp-nvim-lsp"})
	use({"hrsh7th/vim-vsnip"})
	use({"hrsh7th/cmp-path"})

	use({
		'windwp/nvim-ts-autotag',
		config = function()
			require('nvim-ts-autotag').setup()
		end,

	})

	use({
		'haya14busa/vim-edgemotion',
	})


	use {
		'phaazon/hop.nvim',
		as = 'hop',
		config = function()
			require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
		end
	}
	
	use({
		"mattn/vim-goimports",
	})

	use({
		'kevinhwang91/nvim-bqf',
	})
	

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)



