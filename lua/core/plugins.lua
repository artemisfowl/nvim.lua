local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.5',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
	use {
		"folke/todo-comments.nvim",
		requires = {
			"nvim-lua/plenary.nvim"
		}
	}
	use { "catppuccin/nvim", as = "catppuccin" }
	use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate'})
	use {'williamboman/mason.nvim'}

	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		requires = {
			--- Uncomment the two plugins below if you want to manage the language servers from neovim
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},

			-- LSP Support
			{'neovim/nvim-lspconfig'},
			-- Autocompletion
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'L3MON4D3/LuaSnip'},
		}
	}
	use {'neoclide/coc.nvim', branch = 'release'}
	use {'ryanoasis/vim-devicons'}

	use {'nvim-tree/nvim-web-devicons'}
	use {'vim-scripts/Tagbar'}
	-- use {'nvim-lualine/lualine.nvim', requires = { 'nvim-tree/nvim-web-devicons', opt = true }}
	use {'f-person/git-blame.nvim'}
	use {'tpope/vim-fugitive'}
	use {'voldikss/vim-floaterm'}
	use {
		'nvim-tree/nvim-tree.lua',
		requires = {
			'nvim-tree/nvim-web-devicons', -- optional
		},
	}

  use { 'echasnovski/mini.indentscope', version = '*' }

	-- For checking the references
	use {'VidocqH/lsp-lens.nvim'}

	-- because I want the experimental nice things
	--use { 'folke/noice.nvim',
	--opts = {
	--background_color = "#000000"
	--},
	--requires = {
	--'MunifTanjim/nui.nvim',
	--'rcarriga/nvim-notify',
	--}
	--}
	--use { 'akinsho/bufferline.nvim',
	--tag = "*",
	--requires = {'nvim-tree/nvim-web-devicons' }
	--}

	-- Need to have a proper commenting plugin
	use {
		'numToStr/Comment.nvim',
		config = function()
				require('Comment').setup()
		end
	}

	-- Goto the preview
	use {
		'rmagatti/goto-preview',
		config = function()
			require('goto-preview').setup {}
		end
	}

	-- setting up the undo tree using mundo
	use { 'simnalamburt/vim-mundo' }

	-- setting up nvim for go development
	use { 'fatih/vim-go' }

	-- setting up blankline indentation
	--[[use {
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("ibl").setup()
		end
	}
	--]]

	-- setting up the undo tree using mundo
	--use { 'simnalamburt/vim-mundo' }

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end)
